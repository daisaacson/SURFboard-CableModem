Function Get-SurfBoardConfigData {
    [CmdletBinding(SupportsShouldProcess=$True)]
    Param (
        [Parameter(ValueFromPipelineByPropertyName=$true,ValueFromPipeline=$true)]
        [Alias("CN", "SurfBoard", "SB")]
        [String[]]
        $ComputerName = $surfboard
    )
    Begin {
        Write-Verbose "Begin $($MyInvocation.MyCommand)"
        $path = "cmConfigData"
    }
    Process {
        if ($PSCmdlet.ShouldProcess($ComputerName)) {
            $Response = Invoke-WebRequest -Uri "http://$($ComputerName)$($surfboardURIs.$path)"

            $data = [ordered]@{}
            $data.$path = [ordered]@{}
            # cmConfigData page has one table
            foreach ($table in $Response.ParsedHtml.getElementsByTagName("TABLE")) {
                foreach ($row in $table.Rows) {
                    if ($row.Cells[0].tagName -eq "TH") {
                        [string]$element = $row.Cells[0].innerText.Trim()
                        $data.$path.$element = [ordered]@{}
                    } else {
                        try {
                            [string]$key = $row.Cells[0].InnerText.Trim()
                            [string]$value = $row.Cells[1].InnerText.Trim()
                            if ($key -match '(DHCP Server).+') {
                                $key = $Matches[1]
                            }
                            if ($value -match '^(-?\d+\.?\d*)(?:\s+(.+))?$') {
                                [double]$value = $Matches[1]
                                if ($Matches[2]) {
                                    $key = "$key ($($Matches[2]))"
                                }
                            }
                        } catch {}
                        $data.$path.$element.$key = $value
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
Set-Alias -Name gsbcd -Value Get-SurfBoardConfigData