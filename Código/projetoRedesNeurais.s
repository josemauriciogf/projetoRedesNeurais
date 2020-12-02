PC       = 0
EPC      = 0
Cause    = 0
BadVAddr = 0
Status   = 3000ff10

HI       = 0
LO       = 0

R0  [r0] = 0
R1  [at] = 0
R2  [v0] = 0
R3  [v1] = 0
R4  [a0] = 0
R5  [a1] = 0
R6  [a2] = 7ffff778
R7  [a3] = 0
R8  [t0] = 0
R9  [t1] = 0
R10 [t2] = 0
R11 [t3] = 0
R12 [t4] = 0
R13 [t5] = 0
R14 [t6] = 0
R15 [t7] = 0
R16 [s0] = 0
R17 [s1] = 0
R18 [s2] = 0
R19 [s3] = 0
R20 [s4] = 0
R21 [s5] = 0
R22 [s6] = 0
R23 [s7] = 0
R24 [t8] = 0
R25 [t9] = 0
R26 [k0] = 0
R27 [k1] = 0
R28 [gp] = 10008000
R29 [sp] = 7ffff770
R30 [s8] = 0
R31 [ra] = 0


User Text Segment [00400000]..[00440000]
[00400000] 8fa40000  lw $4, 0($29)            ; 183: lw $a0 0($sp) # argc 
[00400004] 27a50004  addiu $5, $29, 4         ; 184: addiu $a1 $sp 4 # argv 
[00400008] 24a60004  addiu $6, $5, 4          ; 185: addiu $a2 $a1 4 # envp 
[0040000c] 00041080  sll $2, $4, 2            ; 186: sll $v0 $a0 2 
[00400010] 00c23021  addu $6, $6, $2          ; 187: addu $a2 $a2 $v0 
[00400014] 0c000000  jal 0x00000000 [main]    ; 188: jal main 
[00400018] 00000000  nop                      ; 189: nop 
[0040001c] 3402000a  ori $2, $0, 10           ; 191: li $v0 10 
[00400020] 0000000c  syscall                  ; 192: syscall # syscall 10 (exit) 

Kernel Text Segment [80000000]..[80010000]
[80000180] 0001d821  addu $27, $0, $1         ; 90: move $k1 $at # Save $at 
[80000184] 3c019000  lui $1, -28672           ; 92: sw $v0 s1 # Not re-entrant and we can't trust $sp 
[80000188] ac220200  sw $2, 512($1)           
[8000018c] 3c019000  lui $1, -28672           ; 93: sw $a0 s2 # But we need to use these registers 
[80000190] ac240204  sw $4, 516($1)           
[80000194] 401a6800  mfc0 $26, $13            ; 95: mfc0 $k0 $13 # Cause register 
[80000198] 001a2082  srl $4, $26, 2           ; 96: srl $a0 $k0 2 # Extract ExcCode Field 
[8000019c] 3084001f  andi $4, $4, 31          ; 97: andi $a0 $a0 0x1f 
[800001a0] 34020004  ori $2, $0, 4            ; 101: li $v0 4 # syscall 4 (print_str) 
[800001a4] 3c049000  lui $4, -28672 [__m1_]   ; 102: la $a0 __m1_ 
[800001a8] 0000000c  syscall                  ; 103: syscall 
[800001ac] 34020001  ori $2, $0, 1            ; 105: li $v0 1 # syscall 1 (print_int) 
[800001b0] 001a2082  srl $4, $26, 2           ; 106: srl $a0 $k0 2 # Extract ExcCode Field 
[800001b4] 3084001f  andi $4, $4, 31          ; 107: andi $a0 $a0 0x1f 
[800001b8] 0000000c  syscall                  ; 108: syscall 
[800001bc] 34020004  ori $2, $0, 4            ; 110: li $v0 4 # syscall 4 (print_str) 
[800001c0] 3344003c  andi $4, $26, 60         ; 111: andi $a0 $k0 0x3c 
[800001c4] 3c019000  lui $1, -28672           ; 112: lw $a0 __excp($a0) 
[800001c8] 00240821  addu $1, $1, $4          
[800001cc] 8c240180  lw $4, 384($1)           
[800001d0] 00000000  nop                      ; 113: nop 
[800001d4] 0000000c  syscall                  ; 114: syscall 
[800001d8] 34010018  ori $1, $0, 24           ; 116: bne $k0 0x18 ok_pc # Bad PC exception requires special checks 
[800001dc] 143a0008  bne $1, $26, 32 [ok_pc-0x800001dc] 
[800001e0] 00000000  nop                      ; 117: nop 
[800001e4] 40047000  mfc0 $4, $14             ; 119: mfc0 $a0 $14 # EPC 
[800001e8] 30840003  andi $4, $4, 3           ; 120: andi $a0 $a0 0x3 # Is EPC word-aligned? 
[800001ec] 10040004  beq $0, $4, 16 [ok_pc-0x800001ec]
[800001f0] 00000000  nop                      ; 122: nop 
[800001f4] 3402000a  ori $2, $0, 10           ; 124: li $v0 10 # Exit on really bad PC 
[800001f8] 0000000c  syscall                  ; 125: syscall 
[800001fc] 34020004  ori $2, $0, 4            ; 128: li $v0 4 # syscall 4 (print_str) 
[80000200] 3c019000  lui $1, -28672 [__m2_]   ; 129: la $a0 __m2_ 
[80000204] 3424000d  ori $4, $1, 13 [__m2_]   
[80000208] 0000000c  syscall                  ; 130: syscall 
[8000020c] 001a2082  srl $4, $26, 2           ; 132: srl $a0 $k0 2 # Extract ExcCode Field 
[80000210] 3084001f  andi $4, $4, 31          ; 133: andi $a0 $a0 0x1f 
[80000214] 14040002  bne $0, $4, 8 [ret-0x80000214]; 134: bne $a0 0 ret # 0 means exception was an interrupt 
[80000218] 00000000  nop                      ; 135: nop 
[8000021c] 401a7000  mfc0 $26, $14            ; 145: mfc0 $k0 $14 # Bump EPC register 
[80000220] 275a0004  addiu $26, $26, 4        ; 146: addiu $k0 $k0 4 # Skip faulting instruction 
[80000224] 409a7000  mtc0 $26, $14            ; 148: mtc0 $k0 $14 
[80000228] 3c019000  lui $1, -28672           ; 153: lw $v0 s1 # Restore other registers 
[8000022c] 8c220200  lw $2, 512($1)           
[80000230] 3c019000  lui $1, -28672           ; 154: lw $a0 s2 
[80000234] 8c240204  lw $4, 516($1)           
[80000238] 001b0821  addu $1, $0, $27         ; 157: move $at $k1 # Restore $at 
[8000023c] 40806800  mtc0 $0, $13             ; 160: mtc0 $0 $13 # Clear Cause register 
[80000240] 401a6000  mfc0 $26, $12            ; 162: mfc0 $k0 $12 # Set Status register 
[80000244] 375a0001  ori $26, $26, 1          ; 163: ori $k0 0x1 # Interrupts enabled 
[80000248] 409a6000  mtc0 $26, $12            ; 164: mtc0 $k0 $12 
[8000024c] 42000018  eret                     ; 167: eret 


User data segment [10000000]..[10040000]
[10000000]..[1003ffff]  00000000


User Stack [7ffff770]..[80000000]
[7ffff770]    00000000  00000000  7fffffe1  7fffffba    . . . . . . . . . . . . . . . . 
[7ffff780]    7fffff89  7fffff4d  7fffff1c  7ffffeff    . . . . M . . . . . . . . . . . 
[7ffff790]    7ffffedb  7ffffea9  7ffffe78  7ffffe50    . . . . . . . . x . . . P . . . 
[7ffff7a0]    7ffffe43  7ffffe2d  7ffffe03  7ffffde5    C . . . - . . . . . . . . . . . 
[7ffff7b0]    7ffffdce  7ffffdad  7ffffd84  7ffffd76    . . . . . . . . . . . . v . . . 
[7ffff7c0]    7ffffb5b  7ffffb1d  7ffffb00  7ffffab7    [ . . . . . . . . . . . . . . . 
[7ffff7d0]    7ffffaa5  7ffffa8d  7ffffa72  7ffffa54    . . . . . . . . r . . . T . . . 
[7ffff7e0]    7ffffa2b  7ffffa0d  7ffff9a2  7ffff98b    + . . . . . . . . . . . . . . . 
[7ffff7f0]    7ffff977  7ffff968  7ffff952  7ffff92b    w . . . h . . . R . . . + . . . 
[7ffff800]    7ffff905  7ffff8ea  7ffff8c0  7ffff8b1    . . . . . . . . . . . . . . . . 
[7ffff810]    7ffff896  7ffff85c  7ffff84a  7ffff828    . . . . \ . . . J . . . ( . . . 
[7ffff820]    00000000  00000000  4f435f5f  5441504d    . . . . . . . . _ _ C O M P A T 
[7ffff830]    59414c5f  443d5245  63657465  73726f74    _ L A Y E R = D e t e c t o r s 
[7ffff840]    48707041  746c6165  69770068  7269646e    A p p H e a l t h . w i n d i r 
[7ffff850]    5c3a433d  444e4957  0053574f  584f4256    = C : \ W I N D O W S . V B O X 
[7ffff860]    49534d5f  534e495f  4c4c4154  5441505f    _ M S I _ I N S T A L L _ P A T 
[7ffff870]    3a433d48  6f72505c  6d617267  6c694620    H = C : \ P r o g r a m   F i l 
[7ffff880]    4f5c7365  6c636172  69565c65  61757472    e s \ O r a c l e \ V i r t u a 
[7ffff890]    786f426c  5355005c  52505245  4c49464f    l B o x \ . U S E R P R O F I L 
[7ffff8a0]    3a433d45  6573555c  6a5c7372  6d65736f    E = C : \ U s e r s \ j o s e m 
[7ffff8b0]    45535500  4d414e52  6f6a3d45  006d6573    . U S E R N A M E = j o s e m . 
[7ffff8c0]    52455355  414d4f44  525f4e49  494d414f    U S E R D O M A I N _ R O A M I 
[7ffff8d0]    5250474e  4c49464f  45443d45  4f544b53    N G P R O F I L E = D E S K T O 
[7ffff8e0]    49342d50  37553954  53550046  4f445245    P - 4 I T 9 U 7 F . U S E R D O 
[7ffff8f0]    4e49414d  5345443d  504f544b  5449342d    M A I N = D E S K T O P - 4 I T 
[7ffff900]    46375539  504d5400  5c3a433d  72657355    9 U 7 F . T M P = C : \ U s e r 
[7ffff910]    6f6a5c73  5c6d6573  44707041  5c617461    s \ j o s e m \ A p p D a t a \ 
[7ffff920]    61636f4c  65545c6c  5400706d  3d504d45    L o c a l \ T e m p . T E M P = 
[7ffff930]    555c3a43  73726573  736f6a5c  415c6d65    C : \ U s e r s \ j o s e m \ A 
[7ffff940]    61447070  4c5c6174  6c61636f  6d65545c    p p D a t a \ L o c a l \ T e m 
[7ffff950]    79530070  6d657473  746f6f52  5c3a433d    p . S y s t e m R o o t = C : \ 
[7ffff960]    444e4957  0053574f  74737953  72446d65    W I N D O W S . S y s t e m D r 
[7ffff970]    3d657669  53003a43  49535345  414e4e4f    i v e = C : . S E S S I O N N A 
[7ffff980]    433d454d  6f736e6f  5000656c  494c4255    M E = C o n s o l e . P U B L I 
[7ffff990]    3a433d43  6573555c  505c7372  696c6275    C = C : \ U s e r s \ P u b l i 
[7ffff9a0]    53500063  75646f4d  6150656c  433d6874    c . P S M o d u l e P a t h = C 
[7ffff9b0]    72505c3a  6172676f  6946206d  5c73656c    : \ P r o g r a m   F i l e s \ 
[7ffff9c0]    646e6957  5073776f  7265776f  6c656853    W i n d o w s P o w e r S h e l 
[7ffff9d0]    6f4d5c6c  656c7564  3a433b73  4e49575c    l \ M o d u l e s ; C : \ W I N 
[7ffff9e0]    53574f44  7379735c  336d6574  69575c32    D O W S \ s y s t e m 3 2 \ W i 
[7ffff9f0]    776f646e  776f5073  68537265  5c6c6c65    n d o w s P o w e r S h e l l \ 
[7ffffa00]    302e3176  646f4d5c  73656c75  6f725000    v 1 . 0 \ M o d u l e s . P r o 
[7ffffa10]    6d617267  33343657  3a433d32  6f72505c    g r a m W 6 4 3 2 = C : \ P r o 
[7ffffa20]    6d617267  6c694620  50007365  72676f72    g r a m   F i l e s . P r o g r 
[7ffffa30]    69466d61  2873656c  29363878  5c3a433d    a m F i l e s ( x 8 6 ) = C : \ 
[7ffffa40]    676f7250  206d6172  656c6946  78282073    P r o g r a m   F i l e s   ( x 
[7ffffa50]    00293638  676f7250  466d6172  73656c69    8 6 ) . P r o g r a m F i l e s 
[7ffffa60]    5c3a433d  676f7250  206d6172  656c6946    = C : \ P r o g r a m   F i l e 
[7ffffa70]    72500073  6172676f  7461446d  3a433d61    s . P r o g r a m D a t a = C : 
[7ffffa80]    6f72505c  6d617267  61746144  4f525000    \ P r o g r a m D a t a . P R O 
[7ffffa90]    53534543  525f524f  53495645  3d4e4f49    C E S S O R _ R E V I S I O N = 
[7ffffaa0]    39306538  4f525000  53534543  4c5f524f    8 e 0 9 . P R O C E S S O R _ L 
[7ffffab0]    4c455645  5000363d  45434f52  524f5353    E V E L = 6 . P R O C E S S O R 
[7ffffac0]    4544495f  4649544e  3d524549  65746e49    _ I D E N T I F I E R = I n t e 
[7ffffad0]    2034366c  696d6146  3620796c  646f4d20    l 6 4   F a m i l y   6   M o d 
[7ffffae0]    31206c65  53203234  70706574  20676e69    e l   1 4 2   S t e p p i n g   
[7ffffaf0]    47202c39  69756e65  6e49656e  006c6574    9 ,   G e n u i n e I n t e l . 
[7ffffb00]    434f5250  4f535345  52415f52  54494843    P R O C E S S O R _ A R C H I T 
[7ffffb10]    55544345  413d4552  3436444d  54415000    E C T U R E = A M D 6 4 . P A T 
[7ffffb20]    54584548  4f432e3d  452e3b4d  2e3b4558    H E X T = . C O M ; . E X E ; . 
[7ffffb30]    3b544142  444d432e  42562e3b  562e3b53    B A T ; . C M D ; . V B S ; . V 
[7ffffb40]    2e3b4542  2e3b534a  3b45534a  4653572e    B E ; . J S ; . J S E ; . W S F 
[7ffffb50]    53572e3b  4d2e3b48  50004353  3d687461    ; . W S H ; . M S C . P a t h = 
[7ffffb60]    505c3a43  72676f72  46206d61  73656c69    C : \ P r o g r a m   F i l e s 
[7ffffb70]    38782820  435c2936  6f6d6d6f  6946206e      ( x 8 6 ) \ C o m m o n   F i 
[7ffffb80]    5c73656c  6361724f  4a5c656c  5c617661    l e s \ O r a c l e \ J a v a \ 
[7ffffb90]    6176616a  68746170  5c3a433b  444e4957    j a v a p a t h ; C : \ W I N D 
[7ffffba0]    5c53574f  74737973  32336d65  5c3a433b    O W S \ s y s t e m 3 2 ; C : \ 
[7ffffbb0]    444e4957  3b53574f  575c3a43  4f444e49    W I N D O W S ; C : \ W I N D O 
[7ffffbc0]    535c5357  65747379  5c32336d  6d656257    W S \ S y s t e m 3 2 \ W b e m 
[7ffffbd0]    5c3a433b  444e4957  5c53574f  74737953    ; C : \ W I N D O W S \ S y s t 
[7ffffbe0]    32336d65  6e69575c  73776f64  65776f50    e m 3 2 \ W i n d o w s P o w e 
[7ffffbf0]    65685372  765c6c6c  5c302e31  5c3a433b    r S h e l l \ v 1 . 0 \ ; C : \ 
[7ffffc00]    444e4957  5c53574f  74737953  32336d65    W I N D O W S \ S y s t e m 3 2 
[7ffffc10]    65704f5c  4853536e  3a433b5c  6f72505c    \ O p e n S S H \ ; C : \ P r o 
[7ffffc20]    6d617267  6c694620  6e5c7365  6a65646f    g r a m   F i l e s \ n o d e j 
[7ffffc30]    433b5c73  72505c3a  6172676f  6946206d    s \ ; C : \ P r o g r a m   F i 
[7ffffc40]    5c73656c  5c746947  3b646d63  505c3a43    l e s \ G i t \ c m d ; C : \ P 
[7ffffc50]    72676f72  46206d61  73656c69  746f645c    r o g r a m   F i l e s \ d o t 
[7ffffc60]    5c74656e  5c3a433b  72657355  6f6a5c73    n e t \ ; C : \ U s e r s \ j o 
[7ffffc70]    5c6d6573  44707041  5c617461  61636f4c    s e m \ A p p D a t a \ L o c a 
[7ffffc80]    694d5c6c  736f7263  5c74666f  646e6957    l \ M i c r o s o f t \ W i n d 
[7ffffc90]    4173776f  3b737070  555c3a43  73726573    o w s A p p s ; C : \ U s e r s 
[7ffffca0]    736f6a5c  415c6d65  61447070  525c6174    \ j o s e m \ A p p D a t a \ R 
[7ffffcb0]    696d616f  6e5c676e  433b6d70  73555c3a    o a m i n g \ n p m ; C : \ U s 
[7ffffcc0]    5c737265  65736f6a  70415c6d  74614470    e r s \ j o s e m \ A p p D a t 
[7ffffcd0]    6f4c5c61  5c6c6163  48746947  65446275    a \ L o c a l \ G i t H u b D e 
[7ffffce0]    6f746b73  69625c70  3a433b6e  6573555c    s k t o p \ b i n ; C : \ U s e 
[7ffffcf0]    6a5c7372  6d65736f  7070415c  61746144    r s \ j o s e m \ A p p D a t a 
[7ffffd00]    636f4c5c  505c6c61  72676f72  5c736d61    \ L o c a l \ P r o g r a m s \ 
[7ffffd10]    7263694d  666f736f  53562074  646f4320    M i c r o s o f t   V S   C o d 
[7ffffd20]    69625c65  3a433b6e  6573555c  6a5c7372    e \ b i n ; C : \ U s e r s \ j 
[7ffffd30]    6d65736f  6f642e5c  74656e74  6f6f745c    o s e m \ . d o t n e t \ t o o 
[7ffffd40]    253b736c  52455355  464f5250  25454c49    l s ; % U S E R P R O F I L E % 
[7ffffd50]    7070415c  61746144  636f4c5c  4d5c6c61    \ A p p D a t a \ L o c a l \ M 
[7ffffd60]    6f726369  74666f73  6e69575c  73776f64    i c r o s o f t \ W i n d o w s 
[7ffffd70]    73707041  534f003b  6e69573d  73776f64    A p p s ; . O S = W i n d o w s 
[7ffffd80]    00544e5f  44656e4f  65766972  736e6f43    _ N T . O n e D r i v e C o n s 
[7ffffd90]    72656d75  5c3a433d  72657355  6f6a5c73    u m e r = C : \ U s e r s \ j o 
[7ffffda0]    5c6d6573  44656e4f  65766972  656e4f00    s e m \ O n e D r i v e . O n e 
[7ffffdb0]    76697244  3a433d65  6573555c  6a5c7372    D r i v e = C : \ U s e r s \ j 
[7ffffdc0]    6d65736f  656e4f5c  76697244  554e0065    o s e m \ O n e D r i v e . N U 
[7ffffdd0]    5245424d  5f464f5f  434f5250  4f535345    M B E R _ O F _ P R O C E S S O 
[7ffffde0]    343d5352  474f4c00  45534e4f  52455652    R S = 4 . L O G O N S E R V E R 
[7ffffdf0]    445c5c3d  544b5345  342d504f  55395449    = \ \ D E S K T O P - 4 I T 9 U 
[7ffffe00]    4c004637  4c41434f  44505041  3d415441    7 F . L O C A L A P P D A T A = 
[7ffffe10]    555c3a43  73726573  736f6a5c  415c6d65    C : \ U s e r s \ j o s e m \ A 
[7ffffe20]    61447070  4c5c6174  6c61636f  4d4f4800    p p D a t a \ L o c a l . H O M 
[7ffffe30]    54415045  555c3d48  73726573  736f6a5c    E P A T H = \ U s e r s \ j o s 
[7ffffe40]    48006d65  44454d4f  45564952  003a433d    e m . H O M E D R I V E = C : . 
[7ffffe50]    5f535046  574f5242  5f524553  52455355    F P S _ B R O W S E R _ U S E R 
[7ffffe60]    4f52505f  454c4946  5254535f  3d474e49    _ P R O F I L E _ S T R I N G = 
[7ffffe70]    61666544  00746c75  5f535046  574f5242    D e f a u l t . F P S _ B R O W 
[7ffffe80]    5f524553  5f505041  464f5250  5f454c49    S E R _ A P P _ P R O F I L E _ 
[7ffffe90]    49525453  493d474e  7265746e  2074656e    S T R I N G = I n t e r n e t   
[7ffffea0]    6c707845  7265726f  69724400  44726576    E x p l o r e r . D r i v e r D 
[7ffffeb0]    3d617461  575c3a43  6f646e69  535c7377    a t a = C : \ W i n d o w s \ S 
[7ffffec0]    65747379  5c32336d  76697244  5c737265    y s t e m 3 2 \ D r i v e r s \ 
[7ffffed0]    76697244  61447265  43006174  70536d6f    D r i v e r D a t a . C o m S p 
[7ffffee0]    433d6365  49575c3a  574f444e  79735c53    e c = C : \ W I N D O W S \ s y 
[7ffffef0]    6d657473  635c3233  652e646d  43006578    s t e m 3 2 \ c m d . e x e . C 
[7fffff00]    55504d4f  4e524554  3d454d41  4b534544    O M P U T E R N A M E = D E S K 
[7fffff10]    2d504f54  39544934  00463755  6d6d6f43    T O P - 4 I T 9 U 7 F . C o m m 
[7fffff20]    72506e6f  6172676f  3436576d  433d3233    o n P r o g r a m W 6 4 3 2 = C 
[7fffff30]    72505c3a  6172676f  6946206d  5c73656c    : \ P r o g r a m   F i l e s \ 
[7fffff40]    6d6d6f43  46206e6f  73656c69  6d6f4300    C o m m o n   F i l e s . C o m 
[7fffff50]    506e6f6d  72676f72  69466d61  2873656c    m o n P r o g r a m F i l e s ( 
[7fffff60]    29363878  5c3a433d  676f7250  206d6172    x 8 6 ) = C : \ P r o g r a m   
[7fffff70]    656c6946  78282073  5c293638  6d6d6f43    F i l e s   ( x 8 6 ) \ C o m m 
[7fffff80]    46206e6f  73656c69  6d6f4300  506e6f6d    o n   F i l e s . C o m m o n P 
[7fffff90]    72676f72  69466d61  3d73656c  505c3a43    r o g r a m F i l e s = C : \ P 
[7fffffa0]    72676f72  46206d61  73656c69  6d6f435c    r o g r a m   F i l e s \ C o m 
[7fffffb0]    206e6f6d  656c6946  50410073  54414450    m o n   F i l e s . A P P D A T 
[7fffffc0]    3a433d41  6573555c  6a5c7372  6d65736f    A = C : \ U s e r s \ j o s e m 
[7fffffd0]    7070415c  61746144  616f525c  676e696d    \ A p p D a t a \ R o a m i n g 
[7fffffe0]    4c4c4100  52455355  4f525053  454c4946    . A L L U S E R S P R O F I L E 
[7ffffff0]    5c3a433d  676f7250  446d6172  00617461    = C : \ P r o g r a m D a t a . 


Kernel data segment [90000000]..[90010000]
[90000000]    78452020  74706563  206e6f69  636f2000        E x c e p t i o n   .   o c 
[90000010]    72727563  61206465  6920646e  726f6e67    c u r r e d   a n d   i g n o r 
[90000020]    000a6465  495b2020  7265746e  74707572    e d . .     [ I n t e r r u p t 
[90000030]    2000205d  4c545b20  20005d42  4c545b20    ]   .     [ T L B ] .     [ T L 
[90000040]    20005d42  4c545b20  20005d42  64415b20    B ] .     [ T L B ] .     [ A d 
[90000050]    73657264  72652073  20726f72  69206e69    d r e s s   e r r o r   i n   i 
[90000060]    2f74736e  61746164  74656620  205d6863    n s t / d a t a   f e t c h ]   
[90000070]    5b202000  72646441  20737365  6f727265    .     [ A d d r e s s   e r r o 
[90000080]    6e692072  6f747320  205d6572  5b202000    r   i n   s t o r e ]   .     [ 
[90000090]    20646142  74736e69  74637572  206e6f69    B a d   i n s t r u c t i o n   
[900000a0]    72646461  5d737365  20200020  6461425b    a d d r e s s ]   .     [ B a d 
[900000b0]    74616420  64612061  73657264  00205d73      d a t a   a d d r e s s ]   . 
[900000c0]    455b2020  726f7272  206e6920  63737973        [ E r r o r   i n   s y s c 
[900000d0]    5d6c6c61  20200020  6572425b  6f706b61    a l l ]   .     [ B r e a k p o 
[900000e0]    5d746e69  20200020  7365525b  65767265    i n t ]   .     [ R e s e r v e 
[900000f0]    6e692064  75727473  6f697463  00205d6e    d   i n s t r u c t i o n ]   . 
[90000100]    5b202000  74697241  74656d68  6f206369    .     [ A r i t h m e t i c   o 
[90000110]    66726576  5d776f6c  20200020  6172545b    v e r f l o w ]   .     [ T r a 
[90000120]    00205d70  5b202000  616f6c46  676e6974    p ]   . .     [ F l o a t i n g 
[90000130]    696f7020  205d746e  20000000  6f435b20      p o i n t ]   . . .     [ C o 
[90000140]    636f7270  005d3220  20000000  444d5b20    p r o c   2 ] . . . .     [ M D 
[90000150]    005d584d  575b2020  68637461  2020005d    M X ] .     [ W a t c h ] .     
[90000160]    63614d5b  656e6968  65686320  005d6b63    [ M a c h i n e   c h e c k ] . 
[90000170]    00000000  5b202000  68636143  00005d65    . . . . .     [ C a c h e ] . . 
[90000180]    90000024  90000033  9000003b  90000043    $ . . . 3 . . . ; . . . C . . . 
[90000190]    9000004b  90000071  9000008d  900000aa    K . . . q . . . . . . . . . . . 
[900001a0]    900000c0  900000d6  900000e6  90000100    . . . . . . . . . . . . . . . . 
[900001b0]    90000101  9000011a  90000124  90000125    . . . . . . . . $ . . . % . . . 
[900001c0]    90000139  9000013a  9000013b  90000148    9 . . . : . . . ; . . . H . . . 
[900001d0]    90000149  9000014a  9000014b  90000154    I . . . J . . . K . . . T . . . 
[900001e0]    9000015e  90000170  90000171  90000172    ^ . . . p . . . q . . . r . . . 
[900001f0]    90000173  90000174  90000175  9000017f    s . . . t . . . u . . . . . . . 
[90000200]..[9000ffff]  00000000


