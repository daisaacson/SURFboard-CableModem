Function Get-SurfBoardHelpData {
    [CmdletBinding(SupportsShouldProcess=$True)]
    Param (
        [Parameter(ValueFromPipelineByPropertyName=$true,ValueFromPipeline=$true)]
        [Alias("CN", "SurfBoard", "SB")]
        [String[]]
        $ComputerName = $surfboard
    )
    Begin {
        Write-Verbose "Begin $($MyInvocation.MyCommand)"
        $path = "cmHelpData"
    }
    Process {
        if ($PSCmdlet.ShouldProcess($ComputerName)){
            $Response = Invoke-WebRequest -Uri "http://$($ComputerName)$($surfboardURIs.$path)"

            $data = [ordered]@{}
            $data.$path = [ordered]@{}
            # cmHelpData page has nested tables, we need the 1st row
            $cmHelpData = $Response.ParsedHtml.getElementsByTagName("TABLE")[0].Rows[0].InnerText.Trim()
            foreach ($line in $cmHelpData -split "`r`n") {
                $key,$value = $($line -split ": ").Trim()
                $data.$path.$key = $value
            }         
            Return $data
        }
    }
    End {
        Write-Verbose "End $($MyInvocation.MyCommand)"
    }
}
Set-Alias -Name gsbhd -Value Get-SurfBoardHelpData