Function Get-SurfBoardSignalData {
    [CmdletBinding(SupportsShouldProcess=$True)]
    Param (
        [Parameter(ValueFromPipelineByPropertyName=$true,ValueFromPipeline=$true)]
        [Alias("CN", "SurfBoard", "SB")]
        [String[]]
        $ComputerName = $surfboard
    )
    Begin {
        Write-Verbose "Begin $($MyInvocation.MyCommand)"
        $path = "cmSignalData"
    }
    Process {
        if ($PSCmdlet.ShouldProcess($ComputerName)) {
            $Response = Invoke-WebRequest -Uri "http://$($ComputerName)$($surfboardURIs.$path)"

            $data = [ordered]@{}
            $data.$path = [ordered]@{}
            # Process each table
            foreach ($table in $Response.ParsedHtml.getElementsByTagName("TABLE")) {
                # Process each row
                foreach ($row in $table.Rows) {
                    $key=$value = $null
                    # If row is a Table Heading, a new hashtable elemant and create an empty array for entries
                    if ($row.Cells[0].tagName -eq "TH") {
                        [string]$element = $row.Cells[0].innerText.Trim()
                        $data.$path.$element = @()
                    # This is data
                    } else {
                        # Process each column.  Colomn 0 is Key, Column X is Value.
                        for ($i = 1; $i -lt @($row.Cells).Count; $i++) {
                            [string]$key = $row.Cells[0].innerText.Trim()
                            [string]$value = $row.Cells[$i].innerText.Trim()
                            if ($key -match '(Power Level).+') {
                                $key = $Matches[1]
                            }
                            if ($value -match '^(-?\d+\.?\d*)(?:\s+(.+))?$') {
                                [double]$value = $Matches[1]
                                if ($Matches[2]) {
                                    $key = "$key ($($Matches[2]))"
                                }
                            }
                            if ($key -eq "Upstream Modulation") {
                                $temp = [ordered]@{}
                                foreach ($line in $value -split "`r`n") {
                                    $k,$v = $line -split " "
                                    $temp.$k = $v
                                }
                                [hashtable]$value = $temp
                            }
                            $array = $i-1
                            # If we have an array at our index, add the element
                            if ($data.$path.$element[$array]) {
                                $data.$path.$element[$array].$key = $value
                            # Add the first array element (1st time we encountered a row for this column)
                            } else {
                                $data.$path.$element += [ordered]@{"$key" = $value}
                            }
                        }
                    }
                }
            }
            Return $data
        }
    }
    End {
        Write-Verbose "End $($MyInvocation.MyCommand)"
    }
}
Set-Alias -Name gsbsd -Value Get-SurfBoardSignalData