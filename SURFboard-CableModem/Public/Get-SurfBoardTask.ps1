Function Get-SurfBoardTask {
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
        $table = "Task"
    }
    Process {
        if ($PSCmdlet.ShouldProcess($ComputerName)){
            Return $(Get-SurfBoardIndexData -ComputerName $ComputerName).$path.$table
        }
    }
    End {
        Write-Verbose "End $($MyInvocation.MyCommand)"

    }
}
Set-Alias -Name gsbt -Value Get-SurfBoardTask