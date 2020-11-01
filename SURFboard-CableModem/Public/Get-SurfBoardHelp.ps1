Function Get-SurfBoardHelp {
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
            Return $(Get-SurfBoardHelpData -ComputerName $ComputerName).$path
        }
    }
    End {
        Write-Verbose "End $($MyInvocation.MyCommand)"
    }
}
Set-Alias -Name gsbh -Value Get-SurfBoardHelp