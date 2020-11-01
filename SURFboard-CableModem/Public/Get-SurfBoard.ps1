Function Get-SurfBoard {
    [CmdletBinding(SupportsShouldProcess=$True)]
    Param (
        [Parameter(ValueFromPipelineByPropertyName=$true,ValueFromPipeline=$true)]
        [Alias("CN", "SurfBoard", "SB")]
        [String[]]
        $ComputerName = $surfboard
    )
    Begin {
        Write-Verbose "Begin $($MyInvocation.MyCommand)"
    }
    Process {
        if ($PSCmdlet.ShouldProcess($ComputerName)) {
            $data = [ordered]@{}
            $data += Get-SurfBoardIndexData -ComputerName $ComputerName
            $data += Get-SurfBoardSignalData -ComputerName $ComputerName
            $data += Get-SurfBoardAddressData -ComputerName $ComputerName
            $data += Get-SurfBoardConfigData -ComputerName $ComputerName
            $data += Get-SurfBoardLogsData -ComputerName $ComputerName
            $data += Get-SurfBoardOpenSourceData -ComputerName $ComputerName
            $data += Get-SurfBoardHelpData -ComputerName $ComputerName
            Return $data
        }
    }
    End {
        Write-Verbose "End $($MyInvocation.MyCommand)"
    }
}
Set-Alias -Name gsb -Value Get-SurfBoard