Function Get-SurfBoardConfig {
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
        $table = "Configuration"
    }
    Process {
        if ($PSCmdlet.ShouldProcess($ComputerName)) {
            Return $(Get-SurfBoardConfigData -ComputerName $ComputerName).$path.$table
        }
    }
    End {
        Write-Verbose "End $($MyInvocation.MyCommand)"

    }
}
Set-Alias -Name gsbc -Value Get-SurfBoardConfig