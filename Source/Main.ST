PROGRAM Main
VAR

    bCAN1InByte0    AT %MB0.0   : BYTE;     (* mapped to Index=2000/Sub1 *)
    bCAN1InByte1    AT %MB1.0   : BYTE;     (* not mapped                *)
    bCAN1InWord0    AT %MW0.0   : WORD;     (* this overlapps 'bCAN1InByte0' and 'bCAN1InByte1' *)

    bCAN1OutByte0   AT %MB256.0 : BYTE;     (* mapped to Index=2030/Sub1 *)
    bCAN1OutByte1   AT %MB257.0 : BYTE;     (* mapped to Index=2030/Sub2 *)

    wOldDataWord                : WORD;
    udiDataCounter              : UDINT := 0;

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

IF (wOldDataWord <> bCAN1InWord0) THEN

    wOldDataWord := bCAN1InWord0;

    udiDataCounter := udiDataCounter + 1;

    bCAN1OutByte0 := bCAN1InByte0;
    bCAN1OutByte1 := UDINT_TO_BYTE (udiDataCounter);

END_IF;

RETURN;




END_PROGRAM