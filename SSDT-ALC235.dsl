// generated from: ./gen_ahhcd.sh ALC235
DefinitionBlock ("", "SSDT", 2, "hack", "ALC235", 0)
{
    External(_SB.PCI0.HDEF, DeviceObj)
    Name(_SB.PCI0.HDEF.RMCF, Package()
    {
        "CodecCommander", Package()
        {
            "Disable", ">y",
        },
        "CodecCommanderPowerHook", Package()
        {
            "Disable", ">y",
        },
        "CodecCommanderProbeInit", Package()
        {
            "Version", 0x020600,
            "10ec_0235", Package()
            {
                "PinConfigDefault", Package()
                {
                    Package(){},
                    Package()
                    {
                        "LayoutID", 3,
                        "PinConfigs", Package()
                        {
                            Package(){},
                            0x12, 0x90a00010,
                            0x14, 0x90170020,
                            0x17, 0x40000030,
                            0x19, 0x008b1040,
                            0x1d, 0x40f79050,
                            0x21, 0x012b1060,
                        },
                    },
                },
                "Custom Commands", Package()
                {
                    Package(){},
                    Package()
                    {
                        "LayoutID", 3,
                        "Command", Buffer()
                        {
                            0x01, 0x47, 0x0c, 0x02,
                            0x02, 0x17, 0x0c, 0x02
                        },
                    },
                },
            },
        },
    })
}
//EOF
