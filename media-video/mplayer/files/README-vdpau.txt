MPlayer patches for VDPAU

Brief Overview:
        These patches add VDPAU support to ffmpeg and MPlayer:

        * HW decode acceleration is provided for MPEG-1/2, H.264 and VC-1.

        * A VDPAU video output module is added to MPlayer.

Current support:
        The NVIDIA 180.06 beta driver for Linux, Solaris, and FreeBSD
        provides initial VDPAU support for some GeForce 8xxx and 9xxx
        series GPUs.  Please see the VDPAU announcement on the nvnews.net
        Linux forum for further details.

Prerequisite:
        The following should be acquired using your distribution package
        management system, or from source if required:

        * Subversion (svn); See http://subversion.tigris.org
        * C development tools: make, gcc, binutils.
        * Various X11 libraries (and their development packages)
          that MPlayer relies upon.

Installing the patch:
        Run the supplied shell script:

        $ sh checkout-patch-build.sh

Running MPlayer:
        $ cd mplayer-vdpau
        $ ./mplayer -vc <VDPAU-codec-name> -vo vdpau <filename>

        'VDPAU-codec-name' can be one of:

            ffmpeg12vdpau
            ffh264vdpau
            ffwmv3vdpau
            ffvc1vdpau

        based on the type of video bitstream (ffmpeg12vdpau for MPEG-1
        or MPEG-2, ffh264vdpau for H.264, ffwmv3vdpau for WMV3, and
        ffvc1vdpau for VC-1).

        If a VDPAU codec is used, the VDPAU output module must be used.

        Alternatively, you may use the VDPAU output module without specifying
        a VDPAU codec. In this case, the bitstream decoding is not accelerated
        using VDPAU, but the decoded video is still presented using VDPAU:

        $ cd mplayer-vdpau
        $ ./mplayer -vo vdpau <filename>

Known Limitations:
        1. Playing some video streams may cause GPU errors and/or hang or
           crash the system.
        2. The skip forward/backward features are not robust yet and
           can cause application or system hangs/crashes.
        3. MPlayer OSD or Composite Picture is currently not supported.
        4. Problems have been observed when building MPlayer with these
           patches using gcc-4.3.2.

Example Movie Clips:
        MPEG:   http://inventaaustralia.zftp.com.nyud.net/videos/MPEGIO3MBPS30sec.mpg
                ./mplayer -vo vdpau -vc ffmpeg12vdpau MPEGIO3MBPS30sec.mpg

        H.264:  http://samples.mplayerhq.hu.nyud.net/V-codecs/h264/PAFF/Grey.ts
                ./mplayer -vo vdpau -vc ffh264vdpau Grey.ts
                http://samples.mplayerhq.hu.nyud.net/V-codecs/h264/nature_704x576_25Hz_1500kbits.h264
                ./mplayer -vo vdpau -vc ffh264vdpau nature_704x576_25Hz_1500kbits.h264

        WMV3:   http://download.microsoft.com.nyud.net/download/0/9/d/09d051c4-decc-4d39-9c57-f520187213a1/Amazing_Caves_720.exe
                    (use `unzip` to extract the .exe)
                ./mplayer -vo vdpau -vc ffwmv3vdpau Amazing_Caves_720.wmv

        VC-1:   http://samples.mplayerhq.hu.nyud.net/V-codecs/WVC1/FlightSimX_720p60_51_15Mbps.wmv
                ./mplayer -vo vdpau -vc ffvc1vdpau FlightSimX_720p60_51_15Mbps.wmv

        Note: .nyud.net added to the above URLs to cache the content on CoralCDN (http://www.coralcdn.org/)

