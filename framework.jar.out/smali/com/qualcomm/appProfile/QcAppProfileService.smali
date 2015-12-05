.class public Lcom/qualcomm/appProfile/QcAppProfileService;
.super Ljava/lang/Object;
.source "QcAppProfileService.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/qualcomm/appProfile/QcAppProfileService$App;
    }
.end annotation


# static fields
.field private static final ANTUTU_PACKAGE_NAME:Ljava/lang/String; = "com.antutu.ABenchMark"

.field private static final ANTUTU_POWERFULL_MODE:I = 0xa

.field private static final ANTUTU_POWERSAVE_MODE:I = 0xb

.field private static final DEBUG_QC_APP_PROFILE:Z = false

.field private static final NOT_ANTUTU_POWERFULL_MODE:I = 0x0

.field private static final NOT_ANTUTU_POWERSAVE_MODE:I = 0x1

.field private static final TAG:Ljava/lang/String; = "QcAppProfile"

.field private static final mAppList:[Lcom/qualcomm/appProfile/QcAppProfileService$App;

.field private static preMode:I


# instance fields
.field private enableAppProfiles:Z

.field private initAppProfiles:Z

.field private mContext:Landroid/content/Context;


# direct methods
.method static constructor <clinit>()V
    .locals 6

    .prologue
    const/4 v5, 0x0

    const/4 v4, 0x1

    .line 73
    sput v5, Lcom/qualcomm/appProfile/QcAppProfileService;->preMode:I

    .line 88
    const/16 v0, 0x21

    new-array v0, v0, [Lcom/qualcomm/appProfile/QcAppProfileService$App;

    new-instance v1, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v2, "com.antutu.ABenchMark"

    invoke-direct {v1, v2, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v1, v0, v5

    new-instance v1, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v2, "com.aurorasoftworks.quadrant.ui.standard"

    invoke-direct {v1, v2, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v1, v0, v4

    const/4 v1, 0x2

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.aurorasoftworks.quadrant.ui.advanced"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/4 v1, 0x3

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.aurorasoftworks.quadrant.ui.professional"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/4 v1, 0x4

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.android.gallery3d"

    invoke-direct {v2, v3, v5, v4, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/4 v1, 0x5

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.passmark.pt_mobile"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/4 v1, 0x6

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.ludashi.benchmark"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/4 v1, 0x7

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string/jumbo v3, "org.zeroxlab.zeroxbenchmark"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x8

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string/jumbo v3, "org.zeroxlab.benchmark"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x9

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string/jumbo v3, "softweg.hw.performance"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0xa

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.qualcomm.qx.neocore"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0xb

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.glbenchmark.glbenchmark20"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0xc

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.glbenchmark.glbenchmark21"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0xd

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.glbenchmark.glbenchmark27"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0xe

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.smartbench.twelve"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0xf

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.futuremark.dmandroid.application:workload"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x10

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.futuremark.dmandroid.application"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x11

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.rightware.uimarkes1"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x12

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.rightware.tdmm2v10jnifree"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x13

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.rightware.tdmm2v10jni"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x14

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.rightware.basemarkgui"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x15

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.android.cts.stub"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x16

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.allego.windmill"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x17

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.threed.jpct.bench"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x18

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.nvidia.linpack"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x19

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "cn.opda.android.activity"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x1a

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "eu.chainfire.cfbench"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x1b

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.HOTICE.MobileTest"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x1c

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.greenecomputing.linpack"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x1d

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "gr.androiddev.BenchmarkPi"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x1e

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.qihoo360.mobilesafe.opti"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x1f

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.qihoo360.mobilesafe.bench"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x20

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.pctvtv.android.ttsx"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    sput-object v0, Lcom/qualcomm/appProfile/QcAppProfileService;->mAppList:[Lcom/qualcomm/appProfile/QcAppProfileService$App;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 47
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 48
    iput-object p1, p0, Lcom/qualcomm/appProfile/QcAppProfileService;->mContext:Landroid/content/Context;

    .line 49
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/qualcomm/appProfile/QcAppProfileService;->enableAppProfiles:Z

    .line 51
    return-void
.end method

.method public static getAppProfilePowerMode(Ljava/lang/String;)I
    .locals 4
    .param p0, "packageName"    # Ljava/lang/String;

    .prologue
    .line 371
    const/4 v1, 0x0

    .line 372
    .local v1, "value":I
    if-nez p0, :cond_0

    move v2, v1

    .line 393
    .end local v1    # "value":I
    .local v2, "value":I
    :goto_0
    return v2

    .line 381
    .end local v2    # "value":I
    .restart local v1    # "value":I
    :cond_0
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_1
    sget-object v3, Lcom/qualcomm/appProfile/QcAppProfileService;->mAppList:[Lcom/qualcomm/appProfile/QcAppProfileService$App;

    array-length v3, v3

    if-ge v0, v3, :cond_3

    .line 382
    sget-object v3, Lcom/qualcomm/appProfile/QcAppProfileService;->mAppList:[Lcom/qualcomm/appProfile/QcAppProfileService$App;

    aget-object v3, v3, v0

    iget v3, v3, Lcom/qualcomm/appProfile/QcAppProfileService$App;->powerMode:I

    if-gtz v3, :cond_2

    .line 381
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 385
    :cond_2
    sget-object v3, Lcom/qualcomm/appProfile/QcAppProfileService;->mAppList:[Lcom/qualcomm/appProfile/QcAppProfileService$App;

    aget-object v3, v3, v0

    iget-object v3, v3, Lcom/qualcomm/appProfile/QcAppProfileService$App;->packageName:Ljava/lang/String;

    invoke-virtual {v3, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 386
    sget-object v3, Lcom/qualcomm/appProfile/QcAppProfileService;->mAppList:[Lcom/qualcomm/appProfile/QcAppProfileService$App;

    aget-object v3, v3, v0

    iget v1, v3, Lcom/qualcomm/appProfile/QcAppProfileService$App;->powerMode:I

    move v2, v1

    .line 390
    .end local v1    # "value":I
    .restart local v2    # "value":I
    goto :goto_0

    .end local v2    # "value":I
    .restart local v1    # "value":I
    :cond_3
    move v2, v1

    .line 393
    .end local v1    # "value":I
    .restart local v2    # "value":I
    goto :goto_0
.end method

.method public static getAppProfileTskinValue(Ljava/lang/String;)I
    .locals 4
    .param p0, "packageName"    # Ljava/lang/String;

    .prologue
    .line 244
    const/4 v1, 0x0

    .line 245
    .local v1, "value":I
    if-nez p0, :cond_0

    move v2, v1

    .line 264
    .end local v1    # "value":I
    .local v2, "value":I
    :goto_0
    return v2

    .line 253
    .end local v2    # "value":I
    .restart local v1    # "value":I
    :cond_0
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_1
    sget-object v3, Lcom/qualcomm/appProfile/QcAppProfileService;->mAppList:[Lcom/qualcomm/appProfile/QcAppProfileService$App;

    array-length v3, v3

    if-ge v0, v3, :cond_3

    .line 254
    sget-object v3, Lcom/qualcomm/appProfile/QcAppProfileService;->mAppList:[Lcom/qualcomm/appProfile/QcAppProfileService$App;

    aget-object v3, v3, v0

    iget v3, v3, Lcom/qualcomm/appProfile/QcAppProfileService$App;->tskinValue:I

    if-gtz v3, :cond_2

    .line 253
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 256
    :cond_2
    sget-object v3, Lcom/qualcomm/appProfile/QcAppProfileService;->mAppList:[Lcom/qualcomm/appProfile/QcAppProfileService$App;

    aget-object v3, v3, v0

    iget-object v3, v3, Lcom/qualcomm/appProfile/QcAppProfileService$App;->packageName:Ljava/lang/String;

    invoke-virtual {v3, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 257
    sget-object v3, Lcom/qualcomm/appProfile/QcAppProfileService;->mAppList:[Lcom/qualcomm/appProfile/QcAppProfileService$App;

    aget-object v3, v3, v0

    iget v1, v3, Lcom/qualcomm/appProfile/QcAppProfileService$App;->tskinValue:I

    move v2, v1

    .line 261
    .end local v1    # "value":I
    .restart local v2    # "value":I
    goto :goto_0

    .end local v2    # "value":I
    .restart local v1    # "value":I
    :cond_3
    move v2, v1

    .line 264
    .end local v1    # "value":I
    .restart local v2    # "value":I
    goto :goto_0
.end method

.method public static getCpuPowersaveBias(Ljava/lang/String;)I
    .locals 4
    .param p0, "packageName"    # Ljava/lang/String;

    .prologue
    .line 286
    const/4 v1, 0x0

    .line 287
    .local v1, "rate":I
    if-nez p0, :cond_0

    move v2, v1

    .line 306
    .end local v1    # "rate":I
    .local v2, "rate":I
    :goto_0
    return v2

    .line 295
    .end local v2    # "rate":I
    .restart local v1    # "rate":I
    :cond_0
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_1
    sget-object v3, Lcom/qualcomm/appProfile/QcAppProfileService;->mAppList:[Lcom/qualcomm/appProfile/QcAppProfileService$App;

    array-length v3, v3

    if-ge v0, v3, :cond_3

    .line 296
    sget-object v3, Lcom/qualcomm/appProfile/QcAppProfileService;->mAppList:[Lcom/qualcomm/appProfile/QcAppProfileService$App;

    aget-object v3, v3, v0

    iget v3, v3, Lcom/qualcomm/appProfile/QcAppProfileService$App;->cpuBias:I

    if-gtz v3, :cond_2

    .line 295
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 298
    :cond_2
    sget-object v3, Lcom/qualcomm/appProfile/QcAppProfileService;->mAppList:[Lcom/qualcomm/appProfile/QcAppProfileService$App;

    aget-object v3, v3, v0

    iget-object v3, v3, Lcom/qualcomm/appProfile/QcAppProfileService$App;->packageName:Ljava/lang/String;

    invoke-virtual {v3, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 299
    sget-object v3, Lcom/qualcomm/appProfile/QcAppProfileService;->mAppList:[Lcom/qualcomm/appProfile/QcAppProfileService$App;

    aget-object v3, v3, v0

    iget v1, v3, Lcom/qualcomm/appProfile/QcAppProfileService$App;->cpuBias:I

    move v2, v1

    .line 303
    .end local v1    # "rate":I
    .restart local v2    # "rate":I
    goto :goto_0

    .end local v2    # "rate":I
    .restart local v1    # "rate":I
    :cond_3
    move v2, v1

    .line 306
    .end local v1    # "rate":I
    .restart local v2    # "rate":I
    goto :goto_0
.end method

.method private isAntutuApp(Ljava/lang/String;)Z
    .locals 2
    .param p1, "packagename"    # Ljava/lang/String;

    .prologue
    .line 76
    const/4 v0, 0x0

    .line 77
    .local v0, "ret":Z
    if-eqz p1, :cond_0

    const-string v1, "com.antutu.ABenchMark"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 78
    const/4 v0, 0x1

    .line 80
    :cond_0
    return v0
.end method

.method public static setAppPowerSaveMode(I)V
    .locals 1
    .param p0, "modeValue"    # I

    .prologue
    .line 421
    sparse-switch p0, :sswitch_data_0

    .line 435
    :goto_0
    return-void

    .line 423
    :sswitch_0
    const-string v0, "antutuFullCore"

    invoke-static {v0}, Landroid/os/SystemService;->start(Ljava/lang/String;)V

    goto :goto_0

    .line 426
    :sswitch_1
    const-string v0, "antutuOneCore"

    invoke-static {v0}, Landroid/os/SystemService;->start(Ljava/lang/String;)V

    goto :goto_0

    .line 429
    :sswitch_2
    const-string/jumbo v0, "powerFullCore"

    invoke-static {v0}, Landroid/os/SystemService;->start(Ljava/lang/String;)V

    goto :goto_0

    .line 432
    :sswitch_3
    const-string/jumbo v0, "powerSaveOneCore"

    invoke-static {v0}, Landroid/os/SystemService;->start(Ljava/lang/String;)V

    goto :goto_0

    .line 421
    :sswitch_data_0
    .sparse-switch
        0x0 -> :sswitch_2
        0x1 -> :sswitch_3
        0xa -> :sswitch_0
        0xb -> :sswitch_1
    .end sparse-switch
.end method

.method private setAppProfilePowerMode(Ljava/lang/String;I)V
    .locals 2
    .param p1, "packageName"    # Ljava/lang/String;
    .param p2, "mode"    # I

    .prologue
    .line 398
    invoke-static {p1}, Lcom/qualcomm/appProfile/QcAppProfileService;->getAppProfilePowerMode(Ljava/lang/String;)I

    move-result v0

    .line 403
    .local v0, "iMode":I
    if-nez p2, :cond_0

    .line 405
    const-string/jumbo v1, "powerFullCore"

    invoke-static {v1}, Landroid/os/SystemService;->start(Ljava/lang/String;)V

    .line 414
    :goto_0
    return-void

    .line 412
    :cond_0
    invoke-static {p2}, Lcom/qualcomm/appProfile/QcAppProfileService;->setAppPowerSaveMode(I)V

    goto :goto_0
.end method

.method private setAppProfileTskin(Ljava/lang/String;)V
    .locals 2
    .param p1, "packageName"    # Ljava/lang/String;

    .prologue
    .line 269
    invoke-static {p1}, Lcom/qualcomm/appProfile/QcAppProfileService;->getAppProfileTskinValue(Ljava/lang/String;)I

    move-result v0

    .line 274
    .local v0, "iValue":I
    if-lez v0, :cond_0

    .line 276
    const-string/jumbo v1, "powerPerformance"

    invoke-static {v1}, Landroid/os/SystemService;->start(Ljava/lang/String;)V

    .line 282
    :goto_0
    return-void

    .line 280
    :cond_0
    const-string/jumbo v1, "powerSave"

    invoke-static {v1}, Landroid/os/SystemService;->start(Ljava/lang/String;)V

    goto :goto_0
.end method

.method private setCpuPowersaveBias(Ljava/lang/String;)V
    .locals 3
    .param p1, "packageName"    # Ljava/lang/String;

    .prologue
    .line 312
    invoke-static {p1}, Lcom/qualcomm/appProfile/QcAppProfileService;->getCpuPowersaveBias(Ljava/lang/String;)I

    move-result v0

    .line 317
    .local v0, "biasValue":I
    if-lez v0, :cond_0

    .line 319
    const-string v1, "/sys/devices/system/cpu/cpufreq/ondemand/powersave_bias"

    const/16 v2, -0x3e8

    invoke-static {v1, v2}, Lcom/qualcomm/appProfile/QcAppProfileService;->writeSysFile(Ljava/lang/String;I)V

    .line 325
    :goto_0
    return-void

    .line 323
    :cond_0
    const-string v1, "/sys/devices/system/cpu/cpufreq/ondemand/powersave_bias"

    const/16 v2, 0x12c

    invoke-static {v1, v2}, Lcom/qualcomm/appProfile/QcAppProfileService;->writeSysFile(Ljava/lang/String;I)V

    goto :goto_0
.end method

.method static writeSysFile(Ljava/lang/String;I)V
    .locals 5
    .param p0, "filepath"    # Ljava/lang/String;
    .param p1, "value"    # I

    .prologue
    .line 225
    const/4 v2, 0x0

    .line 226
    .local v2, "outStream":Ljava/io/PrintWriter;
    const/4 v0, 0x0

    .line 231
    .local v0, "fos":Ljava/io/FileOutputStream;
    :try_start_0
    new-instance v1, Ljava/io/FileOutputStream;

    invoke-direct {v1, p0}, Ljava/io/FileOutputStream;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 232
    .end local v0    # "fos":Ljava/io/FileOutputStream;
    .local v1, "fos":Ljava/io/FileOutputStream;
    :try_start_1
    new-instance v3, Ljava/io/PrintWriter;

    new-instance v4, Ljava/io/OutputStreamWriter;

    invoke-direct {v4, v1}, Ljava/io/OutputStreamWriter;-><init>(Ljava/io/OutputStream;)V

    invoke-direct {v3, v4}, Ljava/io/PrintWriter;-><init>(Ljava/io/Writer;)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1

    .line 233
    .end local v2    # "outStream":Ljava/io/PrintWriter;
    .local v3, "outStream":Ljava/io/PrintWriter;
    :try_start_2
    invoke-virtual {v3, p1}, Ljava/io/PrintWriter;->print(I)V

    .line 234
    invoke-virtual {v3}, Ljava/io/PrintWriter;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_2

    move-object v0, v1

    .end local v1    # "fos":Ljava/io/FileOutputStream;
    .restart local v0    # "fos":Ljava/io/FileOutputStream;
    move-object v2, v3

    .line 240
    .end local v3    # "outStream":Ljava/io/PrintWriter;
    .restart local v2    # "outStream":Ljava/io/PrintWriter;
    :goto_0
    return-void

    .line 235
    :catch_0
    move-exception v4

    goto :goto_0

    .end local v0    # "fos":Ljava/io/FileOutputStream;
    .restart local v1    # "fos":Ljava/io/FileOutputStream;
    :catch_1
    move-exception v4

    move-object v0, v1

    .end local v1    # "fos":Ljava/io/FileOutputStream;
    .restart local v0    # "fos":Ljava/io/FileOutputStream;
    goto :goto_0

    .end local v0    # "fos":Ljava/io/FileOutputStream;
    .end local v2    # "outStream":Ljava/io/PrintWriter;
    .restart local v1    # "fos":Ljava/io/FileOutputStream;
    .restart local v3    # "outStream":Ljava/io/PrintWriter;
    :catch_2
    move-exception v4

    move-object v0, v1

    .end local v1    # "fos":Ljava/io/FileOutputStream;
    .restart local v0    # "fos":Ljava/io/FileOutputStream;
    move-object v2, v3

    .end local v3    # "outStream":Ljava/io/PrintWriter;
    .restart local v2    # "outStream":Ljava/io/PrintWriter;
    goto :goto_0
.end method


# virtual methods
.method public setAppProfile(Ljava/lang/String;)V
    .locals 6
    .param p1, "packageName"    # Ljava/lang/String;

    .prologue
    .line 331
    const-string v3, "QcAppProfile"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "App Profiles packageName:"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 333
    invoke-direct {p0, p1}, Lcom/qualcomm/appProfile/QcAppProfileService;->setAppProfileTskin(Ljava/lang/String;)V

    .line 335
    iget-object v3, p0, Lcom/qualcomm/appProfile/QcAppProfileService;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    const-string/jumbo v4, "tskin_enabled_mode"

    const/4 v5, 0x0

    invoke-static {v3, v4, v5}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v1

    .line 336
    .local v1, "retMode":I
    invoke-direct {p0, p1}, Lcom/qualcomm/appProfile/QcAppProfileService;->isAntutuApp(Ljava/lang/String;)Z

    move-result v0

    .line 337
    .local v0, "isAntutu":Z
    const/4 v2, 0x0

    .line 339
    .local v2, "updateMode":I
    if-eqz v0, :cond_1

    if-eqz v1, :cond_1

    .line 341
    const/16 v2, 0xb

    .line 353
    :goto_0
    sget v3, Lcom/qualcomm/appProfile/QcAppProfileService;->preMode:I

    if-eq v2, v3, :cond_0

    .line 354
    sparse-switch v2, :sswitch_data_0

    .line 366
    :cond_0
    :goto_1
    sput v2, Lcom/qualcomm/appProfile/QcAppProfileService;->preMode:I

    .line 367
    return-void

    .line 342
    :cond_1
    if-eqz v0, :cond_2

    if-nez v1, :cond_2

    .line 344
    const/16 v2, 0xa

    goto :goto_0

    .line 345
    :cond_2
    if-nez v0, :cond_3

    if-eqz v1, :cond_3

    .line 347
    const/4 v2, 0x1

    goto :goto_0

    .line 350
    :cond_3
    const/4 v2, 0x0

    goto :goto_0

    .line 357
    :sswitch_0
    invoke-static {v2}, Lcom/qualcomm/appProfile/QcAppProfileService;->setAppPowerSaveMode(I)V

    goto :goto_1

    .line 361
    :sswitch_1
    invoke-direct {p0, p1, v2}, Lcom/qualcomm/appProfile/QcAppProfileService;->setAppProfilePowerMode(Ljava/lang/String;I)V

    goto :goto_1

    .line 354
    nop

    :sswitch_data_0
    .sparse-switch
        0x0 -> :sswitch_1
        0x1 -> :sswitch_1
        0xa -> :sswitch_0
        0xb -> :sswitch_0
    .end sparse-switch
.end method
