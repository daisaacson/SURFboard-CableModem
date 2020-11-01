Function Get-SurfBoardAddressData {
    [CmdletBinding(SupportsShouldProcess=$True)]
    Param (
        [Parameter(ValueFromPipelineByPropertyName=$true,ValueFromPipeline=$true)]
        [Alias("CN", "SurfBoard", "SB")]
        [String[]]
        $ComputerName = $surfboard
    )
    Begin {
        Write-Verbose "Begin $($MyInvocation.MyCommand)"
        $path = "cmAddressData"
    }
    Process {
        if ($PSCmdlet.ShouldProcess($ComputerName)) {
            $Response = Invoke-WebRequest -Uri "http://$($ComputerName)$($surfboardURIs.$path)"

            $data = [ordered]@{}
            $data.$path = [ordered]@{}
            # 1st table
            foreach ($row in $Response.ParsedHtml.getElementsByTagName("TABLE")[0].Rows) {
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
            # 2nd table
            foreach ($row in $Response.ParsedHtml.getElementsByTagName("TABLE")[1].Rows) {
                $key=$value = $null
                if ($row.Cells[1].tagName -eq "TH") {
                    [string]$element = $row.Cells[1].innerText.Trim()
                    $data.$path.$element = @()
                # This is data
                } else {
                    [string]$key = $row.Cells[1].innerText.Trim()
                    [string]$value = $row.Cells[2].innerText.Trim()
                    $data.$path.$element += [ordered]@{"$key" = $value}
                }
            }            
            Return $data
        }
    }
    End {
        Write-Verbose "End $($MyInvocation.MyCommand)"
    }
}
Set-Alias -Name gsbad -Value Get-SurfBoardAddressData