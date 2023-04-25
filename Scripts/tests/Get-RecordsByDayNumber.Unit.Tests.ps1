BeforeAll {
    . "$PSScriptRoot\..\functions.ps1"
}

Describe "Get-RecordsForDayNumber" {

    Context "SMART-DS profile csv" {

        BeforeAll {
            $inputfile = "..\profiles\com_kvar_2616_pu.csv"

            $content = Get-Content -Path $inputfile

            $periods = 96
        }

        It "Returns correct number of records" {
            $DayNumber = 1

            $records = Get-RecordsForDayNumber -Content $content -DayNumber $DayNumber -PeriodsPerDay $periods

            $records.Length | Should -Be $periods
        }

        It "Starting record is expected" {
            $DayNumber = 1

            $records = Get-RecordsForDayNumber -Content $content -DayNumber $DayNumber -PeriodsPerDay $periods

            $records[0] | Should -Be "0.5045038792068142"

        }

        It "Ending record is expected" {

            $DayNumber = 1

            $records = Get-RecordsForDayNumber -Content $content -DayNumber $DayNumber -PeriodsPerDay $periods

            $records[-1] | Should -Be "0.41394960027727906"
        }
    }

    Context "TMY csv" {

        BeforeAll {
            $inputfile = "..\..\..\NSRB-TMY2020-Bismarck\TMY_irradiance_20230220223304.csv"

            $content = Get-Content -Path $inputfile

            $periods = 96
        }

        It "Starting record is expected for day 1" {
            $DayNumber = 1

            $records = Get-RecordsForDayNumber -Content $content -DayNumber $DayNumber -PeriodsPerDay $periods -StartingLine 1

            $records[0] | Should -Be "1,1,0,0,0,0,0,0,0,1,-0.401628827174173,3.14159265358979,-1.15543653111052,2.79341411417992e-16,-0.740471982017824,-0,0,0,0,0"

        }

        It "Returns correct number of records for day 1" {
            $DayNumber = 1

            $records = Get-RecordsForDayNumber -Content $content -DayNumber $DayNumber -PeriodsPerDay $periods -StartingLine 1

            $records.Length | Should -Be $periods
        }

        It "Ending record is expected for day 1" {

            $DayNumber = 1

            $records = Get-RecordsForDayNumber -Content $content -DayNumber $DayNumber -PeriodsPerDay $periods -StartingLine 1

            $records[-1] | Should -Be "1,1,23,45,0,0,0.87,0,-7.25,1,-0.401628827174173,-3.07614280664001,-1.15210653602514,-0.148613514094205,-0.739646616257821,-0,0,0,0,0"
        }

        It "Starting record is expected for day 365" {
            $DayNumber = 365

            $records = Get-RecordsForDayNumber -Content $content -DayNumber $DayNumber -PeriodsPerDay $periods -StartingLine 1

            $records[0] | Should -Be "12,31,0,0,0,0,0.87,0,-11.8,365,-0.402925157821884,3.14159265358979,-1.15673286175823,2.8001067873598e-16,-0.741342606875585,-0,0,0,0,0"
        }

        It "Ending record is expected for day 365" {
            $DayNumber = 365

            $records = Get-RecordsForDayNumber -Content $content -DayNumber $DayNumber -PeriodsPerDay $periods -StartingLine 1

            $records[-1] | Should -Be "12,31,23,45,0,0,0,0,0,365,-0.402925157821884,-3.07614280664001,-1.15339496250297,-0.148965592249387,-0.740517696230965,-0,0,0,0,0"
        }
    }
}