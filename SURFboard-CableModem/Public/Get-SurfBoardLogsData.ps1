Function Get-SurfBoardLogsData {
    [CmdletBinding(SupportsShouldProcess=$True)]
    Param (
        [Parameter(ValueFromPipelineByPropertyName=$true,ValueFromPipeline=$true)]
        [Alias("CN", "SurfBoard", "SB")]
        [String[]]
        $ComputerName = $surfboard
    )
    Begin {
        Write-Verbose "Begin $($MyInvocation.MyCommand)"
        $path = "cmLogsData"
    }
    Process {
        if ($PSCmdlet.ShouldProcess($ComputerName)){
            $Response = Invoke-WebRequest -Uri "http://$($ComputerName)$($surfboardURIs.$path)"

            $data = [ordered]@{}
            $data.$path = @()
            # $cmLogsData
            foreach ($table in $Response.ParsedHtml.getElementsByTagName("TABLE")) {
                $headings = @()
                foreach ($row in $table.Rows) {
                    if ($row.Cells[0].tagName -eq "TH") {
                        foreach ($cell in $row.Cells) {
                            $headings += $cell.InnerText.Trim()
                        }
                    } else {
                        $line = [ordered]@{}
                        for ($column = 0; $column -lt @($row.Cells).count; $column++) {
                            $line["$($headings[$column])"] = $($row.Cells[$column].InnerText.Trim())
                        }
                        $data.$path += $line
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
Set-Alias -Name gsbld -Value Get-SurfBoardLogsData