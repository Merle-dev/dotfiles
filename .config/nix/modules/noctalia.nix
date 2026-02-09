{
    inputs,
    ...
}: {
    imports = [
        inputs.noctalia.homeModules.default
    ];
    programs.noctalia-shell = {
        enable = true;
        settings = {
            bar = {
                backgroundOpacity = 0.9;
                density = "compact";
                position = "top";
                showCapsule = true;
                showOutline = true;
                widgets = {
                    left = [
                        {
                            id = "SystemMonitor";
                        }                        
                        {
                            id = "Network";
                        }
                        {
                            hideUnoccupied = false;
                            id = "Workspace";
                        }
                        {
                            id = "ActiveWindow";
                        }
                    ];
                    center = [
                        {
                            id = "AudioVisualizer";
                        }
                        {
                            id = "MediaMini";
                        }
                        {
                            id = "AudioVisualizer";
                        }
                    ];
                    right = [
                        {
                            id = "Tray";
                        }
                        {
                            id = "NotificationHistory";
                        }
                        {
                            alwaysShowPercentage = false;
                            id = "Battery";
                            warningThreshold = 30;
                        }
                        {
                            id = "Bluetooth";
                        }
                        {
                            id = "Volume";
                            middleClickCommand = "pwvucontrol";
                        }
                        {
                            id = "Microphone";
                            middleClickCommand = "pwvucontrol";
                        }
                        {
                            formatHorizontal = "HH:mm ddd, MMM dd";
                            formatVertical = "HH mm";
                            id = "Clock";
                            useMonospacedFont = true;
                            usePrimaryColor = true;
                        }
                        {
                            id = "ControlCenter";
                            useDistroLogo = true;
                        }
                    ];
                };
            };
            general = {
                avatarImage = "";
                radiusRatio = 0.8;
            };
            ui = {
                boxBorderEnabled = true;
            };
            colorSchemes.predefinedScheme = "Tokyo Night";
            wallpaper.enabled = false;
            dock.enabled = false;
            nightLight = {
                enabled = true;
                autoSchedule = true;
                nightTemp = "5800";
                dayTemp = "6500";
                manualSunrise = "06:30";
                manualSunset = "19:30";
            };
            location = {
                monthBeforeDay = true;
                name = "Aachen";
            };
            desktopWidgets = {
                enabled = true;
                gridSnap = true;
                monitorWidgets = [
                    {
                        name = "DP-1";
                        widgets = [
                            {
                                hideMode = "visible";
                                id = "MediaPlayer";
                                roundedCorners = true;
                                showAlbumArt = true;
                                showBackground = true;
                                showButtons = true;
                                showVisualizer = true;
                                visualizerType = "linear";
                                x = 280;
                                y = 980;
                            }
                            {
                                diskPath = "/";
                                id = "SystemStat";
                                layout = "bottom";
                                roundedCorners = true;
                                showBackground = true;
                                statType = "CPU";
                                x = 20;
                                y = 940;
                            }
                        ];
                    }
                    {
                        name = "HDMI-A-1";
                        widgets = [
                            {
                                hideMode = "visible";
                                id = "MediaPlayer";
                                roundedCorners = true;
                                showAlbumArt = true;
                                showBackground = true;
                                showButtons = true;
                                showVisualizer = true;
                                visualizerType = "linear";
                                x = 280;
                                y = 980;
                            }
                            {
                                diskPath = "/";
                                id = "SystemStat";
                                layout = "bottom";
                                roundedCorners = true;
                                showBackground = true;
                                statType = "CPU";
                                x = 20;
                                y = 940;
                            }
                        ];
                    }
                ];
            };
        };
    };
}
