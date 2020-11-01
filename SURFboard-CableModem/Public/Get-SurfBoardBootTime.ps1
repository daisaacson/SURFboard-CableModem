Function Get-SurfBoardBootTime {
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
        $table = "Cable Modem Operation"
        $element = "System Up Time"
    }
    Process {
        if ($PSCmdlet.ShouldProcess($ComputerName)) {
            $boottime = [ordered]@{}
            $uptime = $(Get-SurfBoardIndexData -ComputerName $ComputerName).$path.$table.$element
            $currenttime = Get-Date
            $days,$null,$time = $uptime -Split " "
            $hours,$minutes,$seconds = $time -Split ".:"
            $seconds = $seconds -Replace "s$"
            Write-Verbose "Days = [$($days)]"
            Write-Verbose "Time = [$($time)]"
            Write-Verbose "Days = [$($days)]; Hours = [$($hours)]; Minutes = [$($minutes)]; Seconds = [$($seconds)]"
            $boottime.'Current Time' = $currenttime
            $boottime.$element = $uptime
            $boottime.'Boot Time' = $($($($($currenttime.AddDays(-$days)).AddHours(-$hours)).AddMinutes(-$minutes)).AddSeconds(-$seconds))
            
            Return $boottime
        }
    }
    End {
        Write-Verbose "End $($MyInvocation.MyCommand)"
    }
}
Set-Alias -Name gsbbt -Value Get-SurfBoardBootTime