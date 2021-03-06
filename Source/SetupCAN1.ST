PROGRAM SetupCAN1
VAR CONSTANT

    NETNUMBER               : USINT := 1;       (* Netnumber: 0=CAN0, 1=CAN1 *)
    REMOTE_NODE_ID          : USINT := 16#40;   (* NodeID of remote node     *)

END_VAR

VAR

    FB_ReadLocalODEntry     : ReadLocalODEntry;
    FB_WriteLocalODEntry    : WriteLocalODEntry;
    udiCanID                : UDINT;
    dwCanID                 : DWORD;

END_VAR

(*=========================================================================*)
(*      PROGRAM SetupCAN1   (used as Startup Task)                         *)
(*=========================================================================*)
(*                                                                         *)
(*                                                                         *)
(*-------------------------------------------------------------------------*)
(*      (c) SYSTEC electronic GmbH 2013                                    *)
(*=========================================================================*)



(***************************************************************************)
(*                                                                         *)
(*                  Configuration of RPDO1                                 *)
(*                                                                         *)
(***************************************************************************)

(*-------------------------------------------------------------------------*)
(*  Step (1): Disable PDO by setting Bit31 in original(!) CANID            *)
(*-------------------------------------------------------------------------*)

FB_ReadLocalODEntry (
    usiNetNumber_i := NETNUMBER,
    wIndex_i       := 16#1400,      (* Index 1400:  RPDO1 communication parameter *)
    bSubIndex_i    := 1             (* SubIndex 1:  COB-ID used                   *)
    |
    dwCanID := dwData_o);

dwCanID.31 := TRUE;                 (* set Bit31 in CANID to disable the PDO      *)

FB_WriteLocalODEntry (
    usiNetNumber_i := NETNUMBER,
    wIndex_i       := 16#1400,      (* Index 1400:  RPDO1 communication parameter *)
    bSubIndex_i    := 1,            (* SubIndex 1:  COB-ID used                   *)
    dwData_i       := dwCanID,      (* CANID, marked as disabled                  *)
    usiDataType_i  := 4);           (* CANID = DWORD = 4Byte                      *)



(*-------------------------------------------------------------------------*)
(*  Step (2): Delete old mapping by setting Sub0 of PDO mapping index to 0 *)
(*-------------------------------------------------------------------------*)

FB_WriteLocalODEntry (
    usiNetNumber_i := NETNUMBER,
    wIndex_i       := 16#1600,      (* Index 1600:  RPDO1 mapping parameter       *)
    bSubIndex_i    := 0,            (* SubIndex 0:  number of mapped objects      *)
    dwData_i       := 0,            (* set number of used mapping entries to 0    *)
    usiDataType_i  := 4);           (* Sub0 = BYTE = 1Byte                        *)



(*-------------------------------------------------------------------------*)
(*  Step (3): Define new mapping of PDO                                    *)
(*-------------------------------------------------------------------------*)

FB_WriteLocalODEntry (              (* set mapping for 'CAN1InByte0'              *)
    usiNetNumber_i := NETNUMBER,
    wIndex_i       := 16#1600,      (* Index 1600:  RPDO1 mapping parameter       *)
    bSubIndex_i    := 1,            (* SubIndex 1:  1st mapped object             *)
    dwData_i       := 16#20000108,  (* Mapping:     Index=2000, Sub=01, Len=08    *)
    usiDataType_i  := 4);           (* Sub0 = DWORD = 4Byte                       *)

FB_WriteLocalODEntry (              (* set mapping for 'CAN1InByte1'              *)
    usiNetNumber_i := NETNUMBER,
    wIndex_i       := 16#1600,      (* Index 1600:  RPDO1 mapping parameter       *)
    bSubIndex_i    := 2,            (* SubIndex 2:  2st mapped object             *)
    dwData_i       := 16#20000208,  (* Mapping:     Index=2000, Sub=02, Len=08    *)
    usiDataType_i  := 4);           (* Sub0 = DWORD = 4Byte                       *)

FB_WriteLocalODEntry (              (* set mapping for 'CAN1InByte2'              *)
    usiNetNumber_i := NETNUMBER,
    wIndex_i       := 16#1600,      (* Index 1600:  RPDO1 mapping parameter       *)
    bSubIndex_i    := 3,            (* SubIndex 3:  3st mapped object             *)
    dwData_i       := 16#20000308,  (* Mapping:     Index=2000, Sub=03, Len=08    *)
    usiDataType_i  := 4);           (* Sub0 = DWORD = 4Byte                       *)

FB_WriteLocalODEntry (              (* set mapping for 'CAN1InByte3'              *)
    usiNetNumber_i := NETNUMBER,
    wIndex_i       := 16#1600,      (* Index 1600:  RPDO1 mapping parameter       *)
    bSubIndex_i    := 4,            (* SubIndex 4:  4st mapped object             *)
    dwData_i       := 16#20000408,  (* Mapping:     Index=2000, Sub=04, Len=08    *)
    usiDataType_i  := 4);           (* Sub0 = DWORD = 4Byte                       *)

FB_WriteLocalODEntry (              (* set mapping for 'CAN1InByte0'              *)
    usiNetNumber_i := NETNUMBER,
    wIndex_i       := 16#1600,      (* Index 1600:  RPDO1 mapping parameter       *)
    bSubIndex_i    := 5,            (* SubIndex 5:  5st mapped object             *)
    dwData_i       := 16#20000508,  (* Mapping:     Index=2000, Sub=05, Len=08    *)
    usiDataType_i  := 4);           (* Sub0 = DWORD = 4Byte                       *)

FB_WriteLocalODEntry (              (* set mapping for 'CAN1InByte1'              *)
    usiNetNumber_i := NETNUMBER,
    wIndex_i       := 16#1600,      (* Index 1600:  RPDO1 mapping parameter       *)
    bSubIndex_i    := 6,            (* SubIndex 6:  6st mapped object             *)
    dwData_i       := 16#20000608,  (* Mapping:     Index=2000, Sub=06, Len=08    *)
    usiDataType_i  := 4);           (* Sub0 = DWORD = 4Byte                       *)

FB_WriteLocalODEntry (              (* set mapping for 'CAN1InByte0'              *)
    usiNetNumber_i := NETNUMBER,
    wIndex_i       := 16#1600,      (* Index 1600:  RPDO1 mapping parameter       *)
    bSubIndex_i    := 7,            (* SubIndex 7:  7st mapped object             *)
    dwData_i       := 16#20000708,  (* Mapping:     Index=2000, Sub=07, Len=08    *)
    usiDataType_i  := 4);           (* Sub0 = DWORD = 4Byte                       *)

FB_WriteLocalODEntry (              (* set mapping for 'CAN1InByte1'              *)
    usiNetNumber_i := NETNUMBER,
    wIndex_i       := 16#1600,      (* Index 1600:  RPDO1 mapping parameter       *)
    bSubIndex_i    := 8,            (* SubIndex 8:  8st mapped object             *)
    dwData_i       := 16#20000808,  (* Mapping:     Index=2000, Sub=08, Len=08    *)
    usiDataType_i  := 4);           (* Sub0 = DWORD = 4Byte                       *)


(*-------------------------------------------------------------------------*)
(*  Step (4): Enable new mapping by setting number of configured objects   *)
(*-------------------------------------------------------------------------*)

FB_WriteLocalODEntry (
    usiNetNumber_i := NETNUMBER,
    wIndex_i       := 16#1600,      (* Index 1600:  RPDO1 mapping parameter       *)
    bSubIndex_i    := 0,            (* SubIndex 0:  number of mapped objects      *)
    dwData_i       := 8,            (* 1 data object (Sub1) is valid              *)
    usiDataType_i  := 1);           (* Sub0 = BYTE = 1Byte                        *)



(*-------------------------------------------------------------------------*)
(*  Step (5): Enable PDO by setting valid (new) CANID                      *)
(*-------------------------------------------------------------------------*)

dwCanID := USINT_TO_DWORD(REMOTE_NODE_ID) OR 16#00000180;

FB_WriteLocalODEntry (
    usiNetNumber_i := NETNUMBER,
    wIndex_i       := 16#1400,      (* Index 1400:  RPDO1 communication parameter *)
    bSubIndex_i    := 1,            (* SubIndex 1:  COB-ID used                   *)
    dwData_i       := dwCanID,      (* CANID, marked as enabled                   *)
    usiDataType_i  := 4);           (* CANID = DWORD = 4Byte                      *)





(***************************************************************************)
(*                                                                         *)
(*                  Configuration of TPDO1                                 *)
(*                                                                         *)
(***************************************************************************)

(*-------------------------------------------------------------------------*)
(*  Step (1): Disable PDO by setting Bit31 in original(!) CANID            *)
(*-------------------------------------------------------------------------*)

FB_ReadLocalODEntry (
    usiNetNumber_i := NETNUMBER,
    wIndex_i       := 16#1800,      (* Index 1800:  TPDO1 communication parameter *)
    bSubIndex_i    := 1             (* SubIndex 1:  COB-ID used                   *)
    |
    dwCanID := dwData_o);

dwCanID.31 := TRUE;                 (* set Bit31 in CANID to disable the PDO      *)

FB_WriteLocalODEntry (
    usiNetNumber_i := NETNUMBER,
    wIndex_i       := 16#1800,      (* Index 1800:  TPDO1 communication parameter *)
    bSubIndex_i    := 1,            (* SubIndex 1:  COB-ID used                   *)
    dwData_i       := dwCanID,      (* CANID, marked as disabled                  *)
    usiDataType_i  := 4);           (* CANID = DWORD = 4Byte                      *)



(*-------------------------------------------------------------------------*)
(*  Step (2): Delete old mapping by setting Sub0 of PDO mapping index to 0 *)
(*-------------------------------------------------------------------------*)

FB_WriteLocalODEntry (
    usiNetNumber_i := NETNUMBER,
    wIndex_i       := 16#1A00,      (* Index 1A00:  TPDO1 mapping parameter       *)
    bSubIndex_i    := 0,            (* SubIndex 0:  number of mapped objects      *)
    dwData_i       := 0,            (* set number of used mapping entries to 0    *)
    usiDataType_i  := 1);           (* Sub0 = BYTE = 1Byte                        *)



(*-------------------------------------------------------------------------*)
(*  Step (3): Define new mapping of PDO                                    *)
(*-------------------------------------------------------------------------*)

FB_WriteLocalODEntry (              (* set mapping for 'CAN1OutByte0'             *)
    usiNetNumber_i := NETNUMBER,
    wIndex_i       := 16#1A00,      (* Index 1A00:  TPDO1 mapping parameter       *)
    bSubIndex_i    := 1,            (* SubIndex 1:  1st mapped object             *)
    dwData_i       := 16#20300108,  (* Mapping:     Index=2030, Sub=01, Len=08    *)
    usiDataType_i  := 4);           (* Sub0 = DWORD = 4Byte                       *)

FB_WriteLocalODEntry (              (* set mapping for 'CAN1InByte1'              *)
    usiNetNumber_i := NETNUMBER,
    wIndex_i       := 16#1A00,      (* Index 1600:  RPDO1 mapping parameter       *)
    bSubIndex_i    := 2,            (* SubIndex 2:  2nd mapped object             *)
    dwData_i       := 16#20300208,  (* Mapping:     Index=2030, Sub=02, Len=08    *)
    usiDataType_i  := 4);           (* Sub0 = DWORD = 4Byte                       *)

FB_WriteLocalODEntry (              (* set mapping for 'CAN1OutByte2'             *)
    usiNetNumber_i := NETNUMBER,
    wIndex_i       := 16#1A00,      (* Index 1A00:  TPDO1 mapping parameter       *)
    bSubIndex_i    := 3,            (* SubIndex 3:  1st mapped object             *)
    dwData_i       := 16#20300308,  (* Mapping:     Index=2030, Sub=03, Len=08    *)
    usiDataType_i  := 4);           (* Sub0 = DWORD = 4Byte                       *)

FB_WriteLocalODEntry (              (* set mapping for 'CAN1OutByte0'             *)
    usiNetNumber_i := NETNUMBER,
    wIndex_i       := 16#1A00,      (* Index 1A00:  TPDO1 mapping parameter       *)
    bSubIndex_i    := 4,            (* SubIndex 4:  1st mapped object             *)
    dwData_i       := 16#20300408,  (* Mapping:     Index=2030, Sub=04, Len=08    *)
    usiDataType_i  := 4);           (* Sub0 = DWORD = 4Byte                       *)

FB_WriteLocalODEntry (              (* set mapping for 'CAN1InByte1'              *)
    usiNetNumber_i := NETNUMBER,
    wIndex_i       := 16#1A00,      (* Index 1600:  RPDO1 mapping parameter       *)
    bSubIndex_i    := 5,            (* SubIndex 5:  2nd mapped object             *)
    dwData_i       := 16#20300508,  (* Mapping:     Index=2030, Sub=05, Len=08    *)
    usiDataType_i  := 4);           (* Sub0 = DWORD = 4Byte                       *)

FB_WriteLocalODEntry (              (* set mapping for 'CAN1OutByte2'             *)
    usiNetNumber_i := NETNUMBER,
    wIndex_i       := 16#1A00,      (* Index 1A00:  TPDO1 mapping parameter       *)
    bSubIndex_i    := 6,            (* SubIndex 6:  1st mapped object             *)
    dwData_i       := 16#20300608,  (* Mapping:     Index=2030, Sub=06, Len=08    *)
    usiDataType_i  := 4);           (* Sub0 = DWORD = 4Byte                       *)

FB_WriteLocalODEntry (              (* set mapping for 'CAN1OutByte0'             *)
    usiNetNumber_i := NETNUMBER,
    wIndex_i       := 16#1A00,      (* Index 1A00:  TPDO1 mapping parameter       *)
    bSubIndex_i    := 7,            (* SubIndex 7:  1st mapped object             *)
    dwData_i       := 16#20300708,  (* Mapping:     Index=2030, Sub=07, Len=08    *)
    usiDataType_i  := 4);           (* Sub0 = DWORD = 4Byte                       *)

FB_WriteLocalODEntry (              (* set mapping for 'CAN1InByte1'              *)
    usiNetNumber_i := NETNUMBER,
    wIndex_i       := 16#1A00,      (* Index 1600:  RPDO1 mapping parameter       *)
    bSubIndex_i    := 8,            (* SubIndex 8:  2nd mapped object             *)
    dwData_i       := 16#20300808,  (* Mapping:     Index=2030, Sub=08, Len=08    *)
    usiDataType_i  := 4);           (* Sub0 = DWORD = 4Byte                       *)

(*-------------------------------------------------------------------------*)
(*  Step (4): Enable new mapping by setting number of configured objects   *)
(*-------------------------------------------------------------------------*)

FB_WriteLocalODEntry (
    usiNetNumber_i := NETNUMBER,
    wIndex_i       := 16#1A00,      (* Index 1A00:  TPDO1 mapping parameter       *)
    bSubIndex_i    := 0,            (* SubIndex 0:  number of mapped objects      *)
    dwData_i       := 8,            (* 2 data objects (Sub1+Sub2) are valid       *)
    usiDataType_i  := 1);           (* Sub0 = BYTE = 1Byte                        *)



(*-------------------------------------------------------------------------*)
(*  Step (5): Enable PDO by setting valid CANID                            *)
(*-------------------------------------------------------------------------*)

udiCanID := 16#00000200 + USINT_TO_UDINT(REMOTE_NODE_ID);
dwCanID := UDINT_TO_DWORD(udiCanID);

FB_WriteLocalODEntry (
    usiNetNumber_i := NETNUMBER,
    wIndex_i       := 16#1800,      (* Index 1800:  TPDO1 communication parameter *)
    bSubIndex_i    := 1,            (* SubIndex 1:  COB-ID used                   *)
    dwData_i       := dwCanID,      (* CANID, marked as enabled                   *)
    usiDataType_i  := 4);           (* CANID = DWORD = 4Byte                      *)


RETURN;




END_PROGRAM