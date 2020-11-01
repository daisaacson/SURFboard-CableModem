Function Get-SurfBoardDownStream {
    [CmdletBinding(SupportsShouldProcess=$True)]
    Param (
        [Parameter(ValueFromPipelineByPropertyName=$true,ValueFromPipeline=$true)]
        [Alias("CN", "SurfBoard", "SB")]
        [String[]]
        $ComputerName = $surfboard
    )
    Begin {
        Write-Verbose "Begin $($MyInvocation.MyCommand)"
        $path = "cmSignalData"
        $table = "Downstream"
    }
    Process {
        if ($PSCmdlet.ShouldProcess($ComputerName)){
            Return $(Get-SurfBoardSignalData -ComputerName $ComputerName).$path.$table
        }
    }
    End {
        Write-Verbose "End $($MyInvocation.MyCommand)"

    }
}
Set-Alias -Name gsbds -Value Get-SurfBoardDownStream