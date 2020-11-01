Function Get-SurfBoardIndexData {
    [CmdletBinding(SupportsShouldProcess=$True)]
    Param (
        [Parameter(ValueFromPipelineByPropertyName=$true,ValueFromPipeline=$true)]
        [Alias("CN", "SurfBoard", "SB")]
        [String[]]
        $ComputerName = $surfboard
    )
    Begin {
        Write-Verbose "Begin $($MyInvocation.MyCommand)"
        $path = "indexData"
    }
    Process {
        if ($PSCmdlet.ShouldProcess($ComputerName)){
            $Response = Invoke-WebRequest -Uri "http://$($ComputerName)$($surfboardURIs.$path)"

            $data = [ordered]@{}
            $data.$path = [ordered]@{}
            foreach ($table in $Response.ParsedHtml.getElementsByTagName("TABLE")) {
                foreach ($row in $table.Rows) {
                    $key=$value = $null
                    if ($row.Cells[0].tagName -eq "TH") {
                        [string]$element = $row.Cells[0].innerText.Trim()
                        $data.$path.$element = [ordered]@{}
                    } else {
                        [string]$key = $row.Cells[0].InnerText.Trim()
                        [string]$value = $row.Cells[1].InnerText.Trim()
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
Set-Alias -Name gsbid -Value Get-SurfBoardIndexData