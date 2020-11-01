Function Get-SurfBoardOpenSourceData {
    [CmdletBinding(SupportsShouldProcess=$True)]
    Param (
        [Parameter(ValueFromPipelineByPropertyName=$true,ValueFromPipeline=$true)]
        [Alias("CN", "SurfBoard", "SB")]
        [String[]]
        $ComputerName = $surfboard
    )
    Begin {
        Write-Verbose "Begin $($MyInvocation.MyCommand)"
        $path = "cmOpenSourceData"
    }
    Process {
        if ($PSCmdlet.ShouldProcess($ComputerName)){
            $Response = Invoke-WebRequest -Uri "http://$($ComputerName)$($surfboardURIs.$path)"

            $data = [ordered]@{}
            $data.$path = [ordered]@{}
            # cmOpenSourceData page has nested tables, we need the 2nd table
            $data.$path = [ordered]@{}
            foreach ($row in $Response.ParsedHtml.getElementsByTagName("TABLE")[1].Rows) {
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
            Return $data
        }
    }
    End {
        Write-Verbose "End $($MyInvocation.MyCommand)"
    }
}
Set-Alias -Name gsbosd -Value Get-SurfBoardOpenSourceData