Function Get-SurfBoardMAC {
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
        $table = "Known CPE MAC Address (Max 1)"
    }
    Process {
        if ($PSCmdlet.ShouldProcess($ComputerName)) {
            Return $(Get-SurfBoardAddressData -ComputerName $ComputerName).$path.$table
        }
    }
    End {
        Write-Verbose "End $($MyInvocation.MyCommand)"
    }
}
Set-Alias -Name gsbm -Value Get-SurfBoardMAC