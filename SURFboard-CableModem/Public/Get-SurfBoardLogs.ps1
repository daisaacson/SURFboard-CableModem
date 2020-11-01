Function Get-SurfBoardLogs {
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
            Return $(Get-SurfBoardLogsData -ComputerName $ComputerName).$path
        }
    }
    End {
        Write-Verbose "End $($MyInvocation.MyCommand)"

    }
}
Set-Alias -Name gsbl -Value Get-SurfBoardLogs