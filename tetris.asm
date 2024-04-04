;
; FDS disk files
;

; This layout is modified from Brad Smith (rainwarrior)'s FDS example for CA65
; https://github.com/bbbradsmith/NES-ca65-example/tree/fds

; setting the file count 1 higher than files on disk for the license "bypass" technique
FILE_COUNT = 6

.segment "SIDE1A"
; block 1
.byte $01
.byte "*NINTENDO-HVC*"
.byte $00 ; manufacturer
.byte "EIS" ; the original ID was "EI" (tEtrIs?), which makes it hard to create a 3-letter name...
.byte ' ' ; normal disk (another example: 'E'=event)
.byte $01 ; game version 1, since this has altered code
.byte $00 ; side
.byte $00 ; disk
.byte $00 ; disk type
.byte $00 ; unknown
.byte FILE_COUNT ; boot file count
.byte $FF,$FF,$FF,$FF,$FF

; manufacturing date will use the USA release date
.byte $01 ; 1989 (heisei era)
.byte $11 ; november
.byte $01 ; 1 (actual day is unknown)

.byte $49 ; country
.byte $61, $00, $00, $02, $00, $00, $00, $00, $00 ; unknown

; since this has altered code from what would have been used for an "official" version,
; we'll use the port creation date as the disk rewrite date
.byte $99 ; 2024 (showa era, since disk writers kept using it)
.byte $04 ; april
.byte $03 ; 3

.byte $00, $80 ; unknown
.byte $00, $00 ; disk writer serial number
.byte $07 ; unknown
.byte $00 ; disk write count
.byte $00 ; actual disk side
.byte $00 ; disk type?
.byte $00 ; disk version?

; block 2
.byte $02
.byte FILE_COUNT

.segment "FILE0_HDR"
; block 3
.import __FILE0_DAT_RUN__
.import __FILE0_DAT_SIZE__
.byte $03
.byte 0,0
.byte "FILE0..."
.word __FILE0_DAT_RUN__
.word __FILE0_DAT_SIZE__
.byte 0 ; PRG
; block 4
.byte $04
;.segment "FILE0_DAT"
;.incbin "" ; this is code below

.segment "FILE1_HDR"
; block 3
.import __FILE1_DAT_RUN__
.import __FILE1_DAT_SIZE__
.byte $03
.byte 1,1
.byte "FILE1..."
.word __FILE1_DAT_RUN__
.word __FILE1_DAT_SIZE__
.byte 0 ; PRG
; block 4
.byte $04
;.segment "FILE1_DAT"
;.incbin "" ; this is code below

.segment "FILE2_HDR"
; block 3
.import __FILE2_DAT_SIZE__
.import __FILE2_DAT_RUN__
.byte $03
.byte 2,2
.byte "FILE2..."
.word __FILE2_DAT_RUN__
.word __FILE2_DAT_SIZE__
.byte 1 ; CHR
; block 4
.byte $04
.segment "FILE2_DAT"
.incbin "gfx/game_tileset.chr"

.segment "FILE3_HDR"
; block 3
.import __FILE3_DAT_SIZE__
.import __FILE3_DAT_RUN__
.byte $03
.byte 3,3
.byte "FILE3..."
.word __FILE3_DAT_RUN__
.word __FILE3_DAT_SIZE__
.byte 1 ; CHR
; block 4
.byte $04
.segment "FILE3_DAT"
.incbin "gfx/title_menu_tileset.chr"

; This block is the last to load, and enables NMI by "loading" the NMI enable value
; directly into the PPU control register at $2000.
; While the disk loader continues searching for one more boot file,
; eventually an NMI fires, allowing us to take control of the CPU before the
; license screen is displayed.
.segment "FILE4_HDR"
; block 3
.import __FILE4_DAT_SIZE__
.import __FILE4_DAT_RUN__
.byte $03
.byte 4,4
.byte "FILE4..."
.word $2000
.word __FILE4_DAT_SIZE__
.byte 0 ; PRG (CPU:$2000)
; block 4
.byte $04
.segment "FILE4_DAT"
.byte $90 ; enable NMI byte sent to $2000

; PRG segments
.include "main.asm"

