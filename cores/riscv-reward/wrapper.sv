module rvfi_wrapper (
	input         clock,
	input         reset,
	`RVFI_OUTPUTS
);
`include "soc_defines.vh"


   (* keep *) wire [SBUSO_HI:0] mmu_sbuso;
   wire [SBUSI_HI:0] mmu_sbusi = 0; /* for now? */
   wire [7:0]        interrupt_bus = 0;

   (* keep *) wire [29:0] ib__addr_0a;
   (* keep *) wire ib__en_0a;
   (* keep *) wire [29:0] db__addr_3a;
   (* keep *) wire db__en_3a;
   (* keep *) wire [31:0] db__write_data_3a;
   (* keep *) wire [3:0] db__write_en_3a;
   (* keep *) wire [DBC_HI:0] db__cmd_3a;

   (* keep *) `rvformal_rand_reg ib__valid_1a;;
   (* keep *) `rvformal_rand_reg [31:0] ib__data_1a;
   wire              ib__error_1a = 0;
   (* keep *) `rvformal_rand_reg db__valid_4a;;
   (* keep *) `rvformal_rand_reg [31:0] db__data_4a;
   wire              db__error_4a = 0;


   // Actually hook up the CPU
   cpu #(.text_start(0)) cpu(
           .rst                         (reset),
           // Outputs
           .cpu_ctrs                    (),
           .dump_perf_ctrs              (),
           .mmu_sbuso                   (mmu_sbuso[SBUSO_HI:0]),
           .ib__addr_0a                 (ib__addr_0a[29:0]),
           .ib__en_0a                   (ib__en_0a),
           .db__en_3a                   (db__en_3a),
           .db__addr_3a                 (db__addr_3a[29:0]),
           .db__write_data_3a           (db__write_data_3a[31:0]),
           .db__write_en_3a             (db__write_en_3a[3:0]),
           .db__cmd_3a                  (db__cmd_3a[DBC_HI:0]),
           // Inputs
           .clk                         (clock),
           .interrupt_bus               (interrupt_bus[7:0]),
           .mmu_sbusi                   (mmu_sbusi[SBUSI_HI:0]),
           .ib__valid_1a                (ib__valid_1a),
           .ib__error_1a                (ib__error_1a),
           .ib__data_1a                 (ib__data_1a[31:0]),
           .db__valid_4a                (db__valid_4a),
           .db__error_4a                (db__error_4a),
           .db__data_4a                 (db__data_4a[31:0]),
           `RVFI_CONN
           );


endmodule
