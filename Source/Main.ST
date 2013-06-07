PROGRAM Main
VAR
(***************************************************************************************************)
(************************* ShPImg variable define **************************************************)
	Modbus_connect			AT %MB515.0 :BYTE;
	Functions_ShPImg 		AT %MB514.0 :BYTE;
	ModbusAddr_ShPImg 		AT %MB516.0 :BYTE;

	TxNum					AT %MB518.0 :BYTE;
	
	Modbus_data0_Read		AT %MB534.0 :BYTE;	
	Modbus_data1_Read		AT %MB535.0 :BYTE;	
	Modbus_data2_Read		AT %MB536.0 :BYTE;	
	Modbus_data3_Read		AT %MB537.0 :BYTE;	
	Modbus_data4_Read		AT %MB538.0 :BYTE;	
	Modbus_data5_Read		AT %MB539.0 :BYTE;	
	Modbus_data6_Read		AT %MB540.0 :BYTE;	
	Modbus_data7_Read		AT %MB541.0 :BYTE;	
	Modbus_data8_Read		AT %MB542.0 :BYTE;	
	Modbus_data9_Read		AT %MB543.0 :BYTE;	

(***************************************************************************************************)
(************************* CAN variable define *****************************************************)

    bCAN1InByte0    AT %MB0.0   : BYTE;     (* mapped to Index=2000/Sub1 *)
    bCAN1InByte1    AT %MB1.0   : BYTE;     (* mapped to Index=2000/Sub2 *)
    bCAN1InByte2    AT %MB2.0   : BYTE;     (* mapped to Index=2000/Sub3 *)
    bCAN1InByte3    AT %MB3.0   : BYTE;     (* mapped to Index=2000/Sub4 *)
    bCAN1InByte4    AT %MB4.0   : BYTE;     (* mapped to Index=2000/Sub5 *)
    bCAN1InByte5    AT %MB5.0   : BYTE;     (* mapped to Index=2000/Sub6 *)
    bCAN1InByte6    AT %MB6.0   : BYTE;     (* mapped to Index=2000/Sub7 *)
    bCAN1InByte7    AT %MB7.0   : BYTE;     (* mapped to Index=2000/Sub8 *)

    bCAN1InWord0    AT %MW0.0   : WORD;     (* this overlapps 'bCAN1InByte0' and 'bCAN1InByte1' *)
    bCAN1InWord2    AT %MW2.0   : WORD;     (* this overlapps 'bCAN1InByte2' and 'bCAN1InByte3' *)
    bCAN1InWord4    AT %MW4.0   : WORD;     (* this overlapps 'bCAN1InByte4' and 'bCAN1InByte5' *)
    bCAN1InWord6    AT %MW6.0   : WORD;     (* this overlapps 'bCAN1InByte6' and 'bCAN1InByte7' *)

    bCAN1OutByte0   AT %MB256.0 : BYTE;     (* mapped to Index=2030/Sub1 *)
    bCAN1OutByte1   AT %MB257.0 : BYTE;     (* mapped to Index=2030/Sub2 *)
    bCAN1OutByte2   AT %MB258.0 : BYTE;     (* mapped to Index=2030/Sub3 *)
    bCAN1OutByte3   AT %MB259.0 : BYTE;     (* mapped to Index=2030/Sub4 *)
    bCAN1OutByte4   AT %MB260.0 : BYTE;     (* mapped to Index=2030/Sub5 *)
    bCAN1OutByte5   AT %MB261.0 : BYTE;     (* mapped to Index=2030/Sub6 *)
    bCAN1OutByte6   AT %MB262.0 : BYTE;     (* mapped to Index=2030/Sub7 *)
    bCAN1OutByte7   AT %MB263.0 : BYTE;     (* mapped to Index=2030/Sub8 *)

    wOldDataWord0                : WORD;
    wOldDataWord2                : WORD;
    wOldDataWord4                : WORD;
    wOldDataWord6                : WORD;

    udiDataCounter              : UDINT := 0;
(***************************************************************************************************)

END_VAR

(*=========================================================================*)
(*      PROGRAM Main   (used as Main Task)                                 *)
(*=========================================================================*)
(*                                                                         *)
(* This is the main task of this demo project. It only makes some very     *)
(* simple processing of a couple of network variables. This variables are  *)
(* located in the static Object Dictionary and mapped to the marker area   *)
(* of the process image                                                    *)
(*                                                                         *)
(* The important part of this demo project is the Startup Task             *)
(* 'SetupCAN1.ST'. Here the configuration of the 1st RPDO and TPDO of the  *)
(* static local Object Dictionary is done.                                 *)
(*                                                                         *)
(* NOTE: The PLC processes its network variables only in CANopen state     *)
(*       'OPERATIONAL'. Therefore it's necessary that a Master is present  *)
(*       in the network. If there is no other deticated master, configure  *)
(*       the PLC to 'CANopenMaster = ON'.                                  *)
(*                                                                         *)
(*-------------------------------------------------------------------------*)
(*      (c) SYSTEC electronic GmbH 2009     -rs                            *)
(*=========================================================================*)
IF (Modbus_connect <> 1) THEN
	Functions_ShPImg := 1; (*set modbus function code*)
	ModbusAddr_ShPImg := 0; (*set modbus number of frame*)
	Modbus_connect := 1;


END_IF;


IF ((wOldDataWord0 <> bCAN1InWord0) or (wOldDataWord2 <> bCAN1InWord2) 
	or (wOldDataWord4 <> bCAN1InWord4) or (wOldDataWord6 <> bCAN1InWord6)) THEN

    wOldDataWord0 := bCAN1InWord0;
    wOldDataWord2 := bCAN1InWord2;
    wOldDataWord4 := bCAN1InWord4;
    wOldDataWord6 := bCAN1InWord6;

    udiDataCounter := udiDataCounter + 1;

	Modbus_data0_Read := bCAN1InByte0;
	Modbus_data1_Read := bCAN1InByte1;
	Modbus_data2_Read := bCAN1InByte2;
	Modbus_data3_Read := bCAN1InByte3;
	Modbus_data4_Read := bCAN1InByte4;
	Modbus_data5_Read := bCAN1InByte5;
	Modbus_data6_Read := bCAN1InByte6;
	Modbus_data7_Read := bCAN1InByte7;
	
    TxNum := UDINT_TO_BYTE (udiDataCounter);

END_IF;

RETURN;




END_PROGRAM