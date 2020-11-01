Function Get-SurfBoardOpenSource {
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
        $table = "Open Source License"
    }
    Process {
        if ($PSCmdlet.ShouldProcess($ComputerName)){
            Return $(Get-SurfBoardOpenSourceData -ComputerName $ComputerName).$path.$table
        }
    }
    End {
        Write-Verbose "End $($MyInvocation.MyCommand)"
    }
}
Set-Alias -Name gsbos -Value Get-SurfBoardOpenSource