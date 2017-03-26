// To fix mapping of keyboard keys

DefinitionBlock("", "SSDT", 2, "hack", "KBD0", 0)
{
//
// Keyboard/Trackpad
//

    External(_SB.PCI0.LPCB.KBD0, DeviceObj)
    Scope (_SB.PCI0.LPCB.KBD0)
    {
        // Select specific keyboard map in VoodooKBD0eyboard.kext
        Method(_DSM, 4)
        {
            If (!Arg2) { Return (Buffer() { 0x03 } ) }
            Return (Package()
            {
                "RM,oem-id", "LENOVO",
                "RM,oem-table-id", "U430-RMCF",
            })
        }

        // overrides for VoodooPS2 configuration...
        Name(RMCF, Package()
        {
            "Controller", Package()
            {
                "WakeDelay", 0,
            },
            "Sentelic FSP", Package()
            {
                "DisableDevice", ">y",
            },
            "ALPS GlidePoint", Package()
            {
                "DisableDevice", ">y",
            },
            "Mouse", Package()
            {
                "DisableDevice", ">y",
            },
            "Synaptics TouchPad", Package()
            {
                "DynamicEWMode", ">y",
                "MultiFingerVerticalDivisor", 9,
                "MultiFingerHorizontalDivisor", 9,
                "MomentumScrollThreshY", 12,
            },
            "Keyboard", Package()
            {
                "Breakless PS2", Package()
                {
                    Package(){}, // indicates array
                    "e064",
                    "e065",
                    "e068",
                    "e06a",
                    "e027",
                },
                "MaximumMacroTime", 25000000,
                "Macro Inversion", Package()
                {
                    Package(){},
                    // Fn+F4
                    Buffer() { 0xff, 0xff, 0x02, 0x64, 0x00, 0x00, 0x00, 0x00, 0x01, 0x38, 0x01, 0x3e },
                    Buffer() { 0xff, 0xff, 0x02, 0xe4, 0x00, 0x00, 0x00, 0x00, 0x01, 0xbe, 0x01, 0xb8 },
                    // F5 (without Fn)
                    Buffer() { 0xff, 0xff, 0x02, 0x65, 0x01, 0x00, 0x00, 0x00, 0x01, 0x3f },
                    Buffer() { 0xff, 0xff, 0x02, 0xe5, 0x01, 0x00, 0x00, 0x00, 0x01, 0xbf },
                    // Fn+Ctrl+F6
                    Buffer() { 0xff, 0xff, 0x02, 0x27, 0x00, 0x03, 0xff, 0xff, 0x02, 0x66 },
                    Buffer() { 0xff, 0xff, 0x02, 0xa7, 0x00, 0x03, 0xff, 0xff, 0x02, 0xe6 },
                    // Ctrl+F6
                    Buffer() { 0xff, 0xff, 0x02, 0x27, 0x00, 0x03, 0xff, 0xff, 0x02, 0x40 },
                    Buffer() { 0xff, 0xff, 0x02, 0xa7, 0x00, 0x03, 0xff, 0xff, 0x02, 0xc0 },
                    // Fn+F8
                    Buffer() { 0xff, 0xff, 0x02, 0x68, 0x00, 0x00, 0x00, 0x00, 0x02, 0x1d, 0x01, 0x38, 0x01, 0x0f },
                    Buffer() { 0xff, 0xff, 0x02, 0xe8, 0x00, 0x00, 0x00, 0x00, 0x01, 0x8f, 0x01, 0xb8, 0x02, 0x9d },
                    // Fn+F10
                    Buffer() { 0xff, 0xff, 0x02, 0x6a, 0x00, 0x00, 0x00, 0x00, 0x02, 0x5b, 0x01, 0x19 },
                    Buffer() { 0xff, 0xff, 0x02, 0xea, 0x00, 0x00, 0x00, 0x00, 0x01, 0x99, 0x02, 0xdb },
                },
                "Custom ADB Map", Package()
                {
                    Package(){},
                    "e063=3f", // Apple Fn
                    "e064=6b", // F14
                    "e065=71", // F15
                    "e068=4f", // F18
                    "e0f2=65", // special F9
                    "e0fb=6b", // brightness down (was =91)
                    "e0fc=71", // brightness up (was =90)
                    "e06a=70", // video mirror
                },
                "Custom PS2 Map", Package()
                {
                    Package(){},
                    "e037=64", // PrtSc=F13
                },
                "Function Keys Special", Package()
                {
                    Package(){},
                    // The following 12 items map Fn+fkeys to Fn+fkeys
                    "e020=e020",
                    "e02e=e02e",
                    "e030=e030",
                    "e064=e064",
                    "e065=e065",
                    "e066=e028",
                    "e067=e067",
                    "e068=e068",
                    "e069=e0f0",
                    "e06a=e06a",
                    "e06b=e0fb",
                    "e06c=e0fc",
                    // The following 12 items map fkeys to fkeys
                    "3b=3b",
                    "3c=3c",
                    "3d=3d",
                    "3e=3e",
                    "3f=3f",
                    "40=40",
                    "41=41",
                    "42=42",
                    "43=43",
                    "44=44",
                    "57=57",
                    "58=58",
                },
                "Function Keys Standard", Package()
                {
                    Package(){},
                    // The following 12 items map Fn+fkeys to fkeys
                    "e020=3b",
                    "e02e=3c",
                    "e030=3d",
                    "e064=3e",
                    "e065=3f",
                    "e066=40",
                    "e067=41",
                    "e068=42",
                    "e069=e0f2",
                    "e06a=44",
                    "e06b=57",
                    "e06c=58",
                    // The following 12 items map fkeys to Fn+fkeys
                    "3b=e020",
                    "3c=e02e",
                    "3d=e030",
                    "3e=e064",
                    "3f=e065",
                    "40=e028",
                    "41=e067",
                    "42=e068",
                    "43=e0f1",
                    "44=e06a",
                    "57=e0fb",
                    "58=e0fc",
                },
            },
        })

        External(\_SB.PCI0.LPCB.EC0.XQ94, MethodObj)
        External(\_SB.PCI0.LPCB.EC0.BLIS)
        // RKAB/RKAC called for PS2 code e0fb/e0fc (brightness is mapped to it)
        Method(RKAB, 1)
        {
            // if screen is turned off, turn it on...
            If (LNot(\_SB.PCI0.LPCB.EC0.BLIS))
            {
                Store (1, \_SB.PCI0.LPCB.EC0.BLIS)
                \_SB.PCI0.LPCB.EC0.XQ94()
                \_SB.PCI0.LPCB.EC0._Q41()
            }
        }
        Method(RKAC, 1) { RKAB(Arg0) }
        // RKA0 called for PS2 code e0f0 (mapped from normal Fn+F9)
        // RKA1 called for PS2 code e0f1 (mapped from F9, with keys swapped)
        // RKA2 called for PS2 code e0f2 (mapped from Fn+F9, with keys swapped)
        Method (RKA0, 1)
        {
            If (Arg0)
            {
                // normal action for Fn+F9 (without keys swapped, toggle screen)
                \_SB.PCI0.LPCB.EC0.XQ94()
                \_SB.PCI0.LPCB.EC0._Q41()
            }
        }
        Method(RKA1, 1)
        {
            If (Arg0)
            {
                // F9 with keys swapped, do what EC would do (toggle screen)
                Store(LNot(\_SB.PCI0.LPCB.EC0.BLIS), \_SB.PCI0.LPCB.EC0.BLIS)
                RKA0(Arg0)
            }
        }
        Method(RKA2, 1)
        {
            If (Arg0)
            {
                // Fn+F9 with keys swapped, undo what EC would do (avoid toggling screen)
                Store(LNot(\_SB.PCI0.LPCB.EC0.BLIS), \_SB.PCI0.LPCB.EC0.BLIS)
            }
        }
    }

    External(_SB.PCI0.LPCB.EC0, DeviceObj)
    Scope(_SB.PCI0.LPCB.EC0)
    {
        External(TPDS, FieldUnitObj)
        External(\TPVD, FieldUnitObj)
        External(\_SB.PCI0.LPCB.SYVD, IntObj)
        External(\_SB.PCI0.LPCB.ELVD, IntObj)

        // The native _Qxx methods in DSDT are renamed XQxx,
        // so notifications from the EC driver will land here.

        // _Q1D (Fn+F11) called on brightness down key
        Method(_Q1D)
        {
            If (LEqual(TPVD, SYVD))
            {
                // Synaptics
                // e06b: code for brightness down
                Notify(\_SB.PCI0.LPCB.KBD0, 0x046b)
            }
            Else
            {
                // Other(ELAN)
                Notify(\_SB.PCI0.LPCB.KBD0, 0x20)
            }
        }
        //_Q1C (Fn+F12) called on brightness up key
        Method(_Q1C)
        {
            If (LEqual(TPVD, SYVD))
            {
                // Synaptics
                // e06c: code for brightness up
                Notify(\_SB.PCI0.LPCB.KBD0, 0x046c)
            }
            Else
            {
                // Other(ELAN)
                Notify(\_SB.PCI0.LPCB.KBD0, 0x10)
            }
        }
        Method(_Q94)
        {
            If (LEqual(TPVD, SYVD))
            {
                // Synaptics
                // e069 will be mapped to either F10 (44) or e0f0 or e0f2
                Notify(\_SB.PCI0.LPCB.KBD0, 0x0469)
            }
            // Else not implemented for ELAN
        }
        Method(_Q8F)
        {
            // EC toggles TPDS when this key is struck before arriving here
            // We can cancel the toggle by setting TPDS=1 (trackpad enabled)
            Store(1, TPDS)
            If (LEqual(TPVD, SYVD))
            {
                // Synaptics
                // e066 will be mapped to either F6 (40) or e037
                Notify(\_SB.PCI0.LPCB.KBD0, 0x0466)
            }
            // Else not implemented for ELAN
        }
        Method(_Q41)
        {
            // e067 will be mapped to either F7 (41) or itself
            //Notify(\_SB.PCI0.LPCB.KBD0, 0x0467)
        }
    }
}
//EOF
