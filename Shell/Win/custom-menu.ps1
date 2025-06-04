###################################################################################
# MacOS has a utility for creating shortcuts for actions. 
# I wrote this script for a similar purpose in Windows. 
# I hate having to install another software and have it running in the background just to have a simple menu.
# It creates a semi-transparent popup with modern styled buttons.
# The buttons can be used to do anything really, like setting clipboard text; 
# or running a command, etc. 
# I'll keep adding more examples as I find a use case. I also welcome suggestions.
#
#
# # Usage:
# 1. Save this script anywhere on your pc with a .ps1 extension.
#    For example: C:\Scripts\custom-menu.ps1
# 2. Open PowerShell and run the script using the command:
#    powershell -ExecutionPolicy Bypass -File "C:\Scripts\custom-menu.ps1"
#    (Make sure to replace the path with the actual path where you saved the script.)
# You can create a shortcut to the script on your desktop or taskbar for convenience;
# And set it to run as administrator if you need elevated permissions for some actions.
# For this purpose create a new shortcut and set the target to: 
# powershell -WindowStyle Hidden -ExecutionPolicy Bypass -File "C:\Scripts\custom-menu.ps1"
###################################################################################

Add-Type -AssemblyName PresentationFramework

$XAML = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Width="280" Height="180" WindowStyle="None" Topmost="True"
        ResizeMode="NoResize" Background="#CC1E1E1E"
        ShowInTaskbar="False" WindowStartupLocation="Manual"
        AllowsTransparency="True">
    <Window.Resources>
        <Style TargetType="Button">
            <Setter Property="Background" Value="#FF2D2D30"/>
            <Setter Property="Foreground" Value="#FFFFFF"/>
            <Setter Property="FontFamily" Value="Segoe UI"/>
            <Setter Property="FontSize" Value="13"/>
            <Setter Property="Margin" Value="0,5"/>
            <Setter Property="Padding" Value="15,8"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border Background="{TemplateBinding Background}"
                                CornerRadius="4"
                                BorderThickness="0">
                            <ContentPresenter HorizontalAlignment="Center" 
                                            VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter Property="Background" Value="#FF3E3E42"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
    </Window.Resources>
    <Border CornerRadius="8" Background="#CC1E1E1E" BorderThickness="1" 
            BorderBrush="#FF3E3E42">
        <StackPanel Margin="15">
            <Button Name="BTN1" Content="Copy Text Content"/>
            <Button Name="BTN2" Content="Copy Current Time"/>
            <Button Name="BTN3" Content="Go To GitHub"/>
            <Button Name="BTN4" Content="Edit Hosts File"/>
            <Button Name="BTNCLOSE" Content="Close">
                <Button.Style>
                    <Style BasedOn="{StaticResource {x:Type Button}}" 
                           TargetType="Button">
                        <Setter Property="Background" Value="#CC17174B"/>
                        <Style.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter Property="Background" Value="#CC2525AA"/>
                            </Trigger>
                        </Style.Triggers>
                    </Style>
                </Button.Style>
            </Button>
        </StackPanel>
    </Border>
</Window>
"@

Add-Type -AssemblyName PresentationCore

# Properly parse XAML
$reader = (New-Object System.Xml.XmlTextReader ([System.IO.StringReader] $XAML));
$window = [Windows.Markup.XamlReader]::Load($reader);

# Position bottom right
Add-Type -AssemblyName System.Windows.Forms
$screen = [System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea;
$window.Left = $screen.Right - $window.Width - 10 ;
$window.Top = $screen.Bottom - $window.Height - 10;

# Bind buttons
$BTN1 = $window.FindName("BTN1");
$BTN2 = $window.FindName("BTN2");
$BTN3 = $window.FindName("BTN3");
$BTN4 = $window.FindName("BTN4");
$BTNCLOSE = $window.FindName("BTNCLOSE");

$BTN1.Add_Click({ 
  Set-Clipboard "This content is copied to clipboard"; 
  # This is to notify and vanish in a second. 
  # You can safely remove the line below this one if you don't need it.
  msg * /time:1 Copied to clipboard!;
  $window.Close(); 
});

$BTN2.Add_Click({ 
  $currentTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
  Set-Clipboard $currentTime
  msg * /time:1 "Time copied to clipboard!"
  $window.Close();
});

$BTN3.Add_Click({
  Start-Process "https://github.com/adilumer"  # Open URL
  $window.Close();
});

$BTN4.Add_Click({
  try {
    $hostPath = "$env:SystemRoot\System32\drivers\etc\hosts"
    Start-Process notepad.exe -ArgumentList $hostPath -Verb RunAs
  } catch {
      [System.Windows.MessageBox]::Show("Failed to open hosts file: $($_.Exception.Message)", "Error", [System.Windows.MessageBoxButton]::OK, [System.Windows.MessageBoxImage]::Error)
  }
  $window.Close();
});

$BTNCLOSE.Add_Click({ $window.Close(); });

$window.ShowDialog() | Out-Null
