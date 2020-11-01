Function Get-SurfBoardForwardErrorCorrection {
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
            $codewords = Get-SurfBoardSignalStatus -ComputerName $ComputerName
            $fecs = @()
            $unerrored = $($codewords.'Total Unerrored Codewords' | Measure-Object -Sum).Sum
            $corrected = $($codewords.'Total Correctable Codewords' | Measure-Object -Sum).Sum
            $uncorrected = $($codewords.'Total Uncorrectable Codewords' | Measure-Object -Sum).Sum
            $errored = $corrected + $uncorrected
            $total = $unerrored + $errored
            $fec = [ordered]@{}
            $fec.'Channel ID' = "All"
            $fec.'Unerrored (%)' = $unerrored/$total*100
            $fec.'Errored (%)' = $errored/$total*100
            $fec.'Errors Corrected (%)' = $corrected/$errored*100
            $fec.'Errors Uncorrected (%)' = $uncorrected/$errored*100
            $fecs += $fec
            foreach ($codeword in $codewords) {
                $fec = [ordered]@{}
                $channel = $codeword.'Channel ID'
                $unerrored = $codeword.'Total Unerrored Codewords'
                $corrected = $codeword.'Total Correctable Codewords'
                $uncorrected = $codeword.'Total Uncorrectable Codewords'
                $errored = $corrected + $uncorrected
                $total = $unerrored + $errored
                $fec.'Channel ID' = $channel
                $fec.'Unerrored (%)' = $unerrored/$total*100
                $fec.'Errored (%)' = $errored/$total*100
                $fec.'Errors Corrected (%)' = $corrected/$errored*100
                $fec.'Errors Uncorrected (%)' = $uncorrected/$errored*100
                $fecs += $fec
            }
            Return $fecs
        }
    }
    End {
        Write-Verbose "End $($MyInvocation.MyCommand)"

    }
}
Set-Alias -Name gsbfec -Value Get-SurfBoardForwardErrorCorrection