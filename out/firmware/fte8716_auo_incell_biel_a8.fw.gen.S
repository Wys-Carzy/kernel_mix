/* Generated by firmware/Makefile */
    .section .rodata
    .p2align 3
_fw_fte8716_auo_incell_biel_a8_fw_bin:
    .incbin "firmware/fte8716_auo_incell_biel_a8.fw"
_fw_end:
   .section .rodata.str,"aMS",@progbits,1
    .p2align 3
_fw_fte8716_auo_incell_biel_a8_fw_name:
    .string "fte8716_auo_incell_biel_a8.fw"
    .section .builtin_fw,"a",@progbits
    .p2align 3
    .quad _fw_fte8716_auo_incell_biel_a8_fw_name
    .quad _fw_fte8716_auo_incell_biel_a8_fw_bin
    .quad _fw_end - _fw_fte8716_auo_incell_biel_a8_fw_bin
