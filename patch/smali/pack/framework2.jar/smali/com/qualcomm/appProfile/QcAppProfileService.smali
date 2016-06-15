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
.field private static final DEBUG_QC_APP_PROFILE:Z = true

.field private static final TAG:Ljava/lang/String; = "QcAppProfile"

.field private static final mAppList:[Lcom/qualcomm/appProfile/QcAppProfileService$App;


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

    .line 67
    const/16 v0, 0x26

    new-array v0, v0, [Lcom/qualcomm/appProfile/QcAppProfileService$App;

    new-instance v1, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v2, "com.antutu.ABenchMark"

    invoke-direct {v1, v2, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v1, v0, v5

    new-instance v1, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v2, "antutu"

    invoke-direct {v1, v2, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v1, v0, v4

    const/4 v1, 0x2

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "ABenchMark"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/4 v1, 0x3

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.qqfriends.com.music"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/4 v1, 0x4

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.aurorasoftworks.quadrant.ui.standard"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/4 v1, 0x5

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.aurorasoftworks.quadrant.ui.advanced"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/4 v1, 0x6

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.aurorasoftworks.quadrant.ui.professional"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/4 v1, 0x7

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.zte.camera"

    invoke-direct {v2, v3, v5, v4, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x8

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.android.gallery3d"

    invoke-direct {v2, v3, v5, v4, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x9

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.android.contacts"

    invoke-direct {v2, v3, v5, v4, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0xa

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.passmark.pt_mobile"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0xb

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.ludashi.benchmark"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0xc

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "org.zeroxlab.zeroxbenchmark"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0xd

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "org.zeroxlab.benchmark"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0xe

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "softweg.hw.performance"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0xf

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.qualcomm.qx.neocore"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x10

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.glbenchmark.glbenchmark20"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x11

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.glbenchmark.glbenchmark21"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x12

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.glbenchmark.glbenchmark27"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x13

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.smartbench.twelve"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x14

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.futuremark.dmandroid.application:workload"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x15

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.futuremark.dmandroid.application"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x16

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.rightware.uimarkes1"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x17

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.rightware.tdmm2v10jnifree"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x18

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.rightware.tdmm2v10jni"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x19

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.rightware.basemarkgui"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x1a

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.android.cts.stub"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x1b

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.allego.windmill"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x1c

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.threed.jpct.bench"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x1d

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.nvidia.linpack"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x1e

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "cn.opda.android.activity"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x1f

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "eu.chainfire.cfbench"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x20

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.HOTICE.MobileTest"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x21

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.greenecomputing.linpack"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x22

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "gr.androiddev.BenchmarkPi"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x23

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.qihoo360.mobilesafe.opti"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x24

    new-instance v2, Lcom/qualcomm/appProfile/QcAppProfileService$App;

    const-string v3, "com.qihoo360.mobilesafe.bench"

    invoke-direct {v2, v3, v4, v5, v4}, Lcom/qualcomm/appProfile/QcAppProfileService$App;-><init>(Ljava/lang/String;III)V

    aput-object v2, v0, v1

    const/16 v1, 0x25

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
    .locals 6
    .param p0, "packageName"    # Ljava/lang/String;

    .prologue
    .line 345
    const/4 v1, 0x0

    .line 346
    .local v1, "value":I
    if-nez p0, :cond_0

    move v2, v1

    .line 367
    .end local v1    # "value":I
    .local v2, "value":I
    :goto_0
    return v2

    .line 351
    .end local v2    # "value":I
    .restart local v1    # "value":I
    :cond_0
    const-string v3, "QcAppProfile"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, " getAppProfilePowerMode packageName = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 352
    const-string v3, "QcAppProfile"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, " getAppProfilePowerMode mAppList.length = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    sget-object v5, Lcom/qualcomm/appProfile/QcAppProfileService;->mAppList:[Lcom/qualcomm/appProfile/QcAppProfileService$App;

    array-length v5, v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 355
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_1
    sget-object v3, Lcom/qualcomm/appProfile/QcAppProfileService;->mAppList:[Lcom/qualcomm/appProfile/QcAppProfileService$App;

    array-length v3, v3

    if-ge v0, v3, :cond_4

    .line 356
    sget-object v3, Lcom/qualcomm/appProfile/QcAppProfileService;->mAppList:[Lcom/qualcomm/appProfile/QcAppProfileService$App;

    aget-object v3, v3, v0

    iget v3, v3, Lcom/qualcomm/appProfile/QcAppProfileService$App;->powerMode:I

    if-gtz v3, :cond_2

    .line 355
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 359
    :cond_2
    sget-object v3, Lcom/qualcomm/appProfile/QcAppProfileService;->mAppList:[Lcom/qualcomm/appProfile/QcAppProfileService$App;

    aget-object v3, v3, v0

    iget-object v3, v3, Lcom/qualcomm/appProfile/QcAppProfileService$App;->packageName:Ljava/lang/String;

    invoke-virtual {v3, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_3

    sget-object v3, Lcom/qualcomm/appProfile/QcAppProfileService;->mAppList:[Lcom/qualcomm/appProfile/QcAppProfileService$App;

    aget-object v3, v3, v0

    iget-object v3, v3, Lcom/qualcomm/appProfile/QcAppProfileService$App;->packageName:Ljava/lang/String;

    invoke-virtual {p0, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 360
    :cond_3
    sget-object v3, Lcom/qualcomm/appProfile/QcAppProfileService;->mAppList:[Lcom/qualcomm/appProfile/QcAppProfileService$App;

    aget-object v3, v3, v0

    iget v1, v3, Lcom/qualcomm/appProfile/QcAppProfileService$App;->powerMode:I

    .line 362
    const-string v3, "QcAppProfile"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "getAppProfilePowerMode found matched app.returning PowerModeValue  as "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move v2, v1

    .line 364
    .end local v1    # "value":I
    .restart local v2    # "value":I
    goto :goto_0

    .end local v2    # "value":I
    .restart local v1    # "value":I
    :cond_4
    move v2, v1

    .line 367
    .end local v1    # "value":I
    .restart local v2    # "value":I
    goto :goto_0
.end method

.method public static getAppProfileTskinValue(Ljava/lang/String;)I
    .locals 6
    .param p0, "packageName"    # Ljava/lang/String;

    .prologue
    .line 243
    const/4 v1, 0x0

    .line 244
    .local v1, "value":I
    if-nez p0, :cond_0

    move v2, v1

    .line 263
    .end local v1    # "value":I
    .local v2, "value":I
    :goto_0
    return v2

    .line 248
    .end local v2    # "value":I
    .restart local v1    # "value":I
    :cond_0
    const-string v3, "QcAppProfile"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, " getAppProfileTskinValue packageName = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " mAppList.length = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    sget-object v5, Lcom/qualcomm/appProfile/QcAppProfileService;->mAppList:[Lcom/qualcomm/appProfile/QcAppProfileService$App;

    array-length v5, v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 252
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_1
    sget-object v3, Lcom/qualcomm/appProfile/QcAppProfileService;->mAppList:[Lcom/qualcomm/appProfile/QcAppProfileService$App;

    array-length v3, v3

    if-ge v0, v3, :cond_4

    .line 253
    sget-object v3, Lcom/qualcomm/appProfile/QcAppProfileService;->mAppList:[Lcom/qualcomm/appProfile/QcAppProfileService$App;

    aget-object v3, v3, v0

    iget v3, v3, Lcom/qualcomm/appProfile/QcAppProfileService$App;->tskinValue:I

    if-gtz v3, :cond_2

    .line 252
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 255
    :cond_2
    sget-object v3, Lcom/qualcomm/appProfile/QcAppProfileService;->mAppList:[Lcom/qualcomm/appProfile/QcAppProfileService$App;

    aget-object v3, v3, v0

    iget-object v3, v3, Lcom/qualcomm/appProfile/QcAppProfileService$App;->packageName:Ljava/lang/String;

    invoke-virtual {v3, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_3

    sget-object v3, Lcom/qualcomm/appProfile/QcAppProfileService;->mAppList:[Lcom/qualcomm/appProfile/QcAppProfileService$App;

    aget-object v3, v3, v0

    iget-object v3, v3, Lcom/qualcomm/appProfile/QcAppProfileService$App;->packageName:Ljava/lang/String;

    invoke-virtual {p0, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 256
    :cond_3
    sget-object v3, Lcom/qualcomm/appProfile/QcAppProfileService;->mAppList:[Lcom/qualcomm/appProfile/QcAppProfileService$App;

    aget-object v3, v3, v0

    iget v1, v3, Lcom/qualcomm/appProfile/QcAppProfileService$App;->tskinValue:I

    .line 258
    const-string v3, "QcAppProfile"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "getAppProfileTskinValue found matched app.returning PowerModeValue  as "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move v2, v1

    .line 260
    .end local v1    # "value":I
    .restart local v2    # "value":I
    goto :goto_0

    .end local v2    # "value":I
    .restart local v1    # "value":I
    :cond_4
    move v2, v1

    .line 263
    .end local v1    # "value":I
    .restart local v2    # "value":I
    goto :goto_0
.end method

.method public static getCpuPowersaveBias(Ljava/lang/String;)I
    .locals 6
    .param p0, "packageName"    # Ljava/lang/String;

    .prologue
    .line 285
    const/4 v1, 0x0

    .line 286
    .local v1, "rate":I
    if-nez p0, :cond_0

    move v2, v1

    .line 305
    .end local v1    # "rate":I
    .local v2, "rate":I
    :goto_0
    return v2

    .line 290
    .end local v2    # "rate":I
    .restart local v1    # "rate":I
    :cond_0
    const-string v3, "QcAppProfile"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, " getCpuPowersaveBias packageName = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " mAppList.length = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    sget-object v5, Lcom/qualcomm/appProfile/QcAppProfileService;->mAppList:[Lcom/qualcomm/appProfile/QcAppProfileService$App;

    array-length v5, v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 294
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_1
    sget-object v3, Lcom/qualcomm/appProfile/QcAppProfileService;->mAppList:[Lcom/qualcomm/appProfile/QcAppProfileService$App;

    array-length v3, v3

    if-ge v0, v3, :cond_3

    .line 295
    sget-object v3, Lcom/qualcomm/appProfile/QcAppProfileService;->mAppList:[Lcom/qualcomm/appProfile/QcAppProfileService$App;

    aget-object v3, v3, v0

    iget v3, v3, Lcom/qualcomm/appProfile/QcAppProfileService$App;->cpuBias:I

    if-gtz v3, :cond_2

    .line 294
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 297
    :cond_2
    sget-object v3, Lcom/qualcomm/appProfile/QcAppProfileService;->mAppList:[Lcom/qualcomm/appProfile/QcAppProfileService$App;

    aget-object v3, v3, v0

    iget-object v3, v3, Lcom/qualcomm/appProfile/QcAppProfileService$App;->packageName:Ljava/lang/String;

    invoke-virtual {v3, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 298
    sget-object v3, Lcom/qualcomm/appProfile/QcAppProfileService;->mAppList:[Lcom/qualcomm/appProfile/QcAppProfileService$App;

    aget-object v3, v3, v0

    iget v1, v3, Lcom/qualcomm/appProfile/QcAppProfileService$App;->cpuBias:I

    .line 300
    const-string v3, "QcAppProfile"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "getCpuPowersaveBias found matched app.returning Powersave BiasValue  as "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move v2, v1

    .line 302
    .end local v1    # "rate":I
    .restart local v2    # "rate":I
    goto :goto_0

    .end local v2    # "rate":I
    .restart local v1    # "rate":I
    :cond_3
    move v2, v1

    .line 305
    .end local v1    # "rate":I
    .restart local v2    # "rate":I
    goto :goto_0
.end method

.method public static setAppPowerSaveMode(I)V
    .locals 3
    .param p0, "modeValue"    # I

    .prologue
    .line 391
    const-string v0, "QcAppProfile"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setAppPowerSaveMode modeValue = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 395
    if-nez p0, :cond_0

    .line 397
    const-string v0, "powerFullCore"

    invoke-static {v0}, Landroid/os/SystemService;->start(Ljava/lang/String;)V

    .line 400
    :cond_0
    const/4 v0, 0x1

    if-ne v0, p0, :cond_1

    .line 402
    const-string v0, "powerSaveOneCore"

    invoke-static {v0}, Landroid/os/SystemService;->start(Ljava/lang/String;)V

    .line 404
    :cond_1
    return-void
.end method

.method private setAppProfilePowerMode(Ljava/lang/String;I)V
    .locals 4
    .param p1, "packageName"    # Ljava/lang/String;
    .param p2, "mode"    # I

    .prologue
    .line 372
    invoke-static {p1}, Lcom/qualcomm/appProfile/QcAppProfileService;->getAppProfilePowerMode(Ljava/lang/String;)I

    move-result v0

    .line 374
    .local v0, "iMode":I
    const-string v1, "QcAppProfile"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, " setAppProfilePowerMode App iMode = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 377
    if-lez v0, :cond_0

    .line 379
    const-string v1, "powerFullCore"

    invoke-static {v1}, Landroid/os/SystemService;->start(Ljava/lang/String;)V

    .line 388
    :goto_0
    return-void

    .line 384
    :cond_0
    const-string v1, "QcAppProfile"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, " setAppProfilePowerMode original mode = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 386
    invoke-static {p2}, Lcom/qualcomm/appProfile/QcAppProfileService;->setAppPowerSaveMode(I)V

    goto :goto_0
.end method

.method private setAppProfileTskin(Ljava/lang/String;)V
    .locals 4
    .param p1, "packageName"    # Ljava/lang/String;

    .prologue
    .line 268
    invoke-static {p1}, Lcom/qualcomm/appProfile/QcAppProfileService;->getAppProfileTskinValue(Ljava/lang/String;)I

    move-result v0

    .line 270
    .local v0, "iValue":I
    const-string v1, "QcAppProfile"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, " setAppProfileTskin App iValue = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 273
    if-lez v0, :cond_0

    .line 275
    const-string v1, "powerPerformance"

    invoke-static {v1}, Landroid/os/SystemService;->start(Ljava/lang/String;)V

    .line 281
    :goto_0
    return-void

    .line 279
    :cond_0
    const-string v1, "powerSave"

    invoke-static {v1}, Landroid/os/SystemService;->start(Ljava/lang/String;)V

    goto :goto_0
.end method

.method private setCpuPowersaveBias(Ljava/lang/String;)V
    .locals 4
    .param p1, "packageName"    # Ljava/lang/String;

    .prologue
    .line 311
    invoke-static {p1}, Lcom/qualcomm/appProfile/QcAppProfileService;->getCpuPowersaveBias(Ljava/lang/String;)I

    move-result v0

    .line 314
    .local v0, "biasValue":I
    const-string v1, "QcAppProfile"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, " setCpuPowersaveBias rate = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 316
    if-lez v0, :cond_0

    .line 318
    const-string v1, "/sys/devices/system/cpu/cpufreq/ondemand/powersave_bias"

    const/16 v2, -0x3e8

    invoke-static {v1, v2}, Lcom/qualcomm/appProfile/QcAppProfileService;->writeSysFile(Ljava/lang/String;I)V

    .line 324
    :goto_0
    return-void

    .line 322
    :cond_0
    const-string v1, "/sys/devices/system/cpu/cpufreq/ondemand/powersave_bias"

    const/16 v2, 0x12c

    invoke-static {v1, v2}, Lcom/qualcomm/appProfile/QcAppProfileService;->writeSysFile(Ljava/lang/String;I)V

    goto :goto_0
.end method

.method static writeSysFile(Ljava/lang/String;I)V
    .locals 8
    .param p0, "filepath"    # Ljava/lang/String;
    .param p1, "value"    # I

    .prologue
    .line 224
    const/4 v3, 0x0

    .line 225
    .local v3, "outStream":Ljava/io/PrintWriter;
    const/4 v1, 0x0

    .line 227
    .local v1, "fos":Ljava/io/FileOutputStream;
    const-string v5, "QcAppProfile"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "writeSysFile filepath = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " value ="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 230
    :try_start_0
    new-instance v2, Ljava/io/FileOutputStream;

    invoke-direct {v2, p0}, Ljava/io/FileOutputStream;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 231
    .end local v1    # "fos":Ljava/io/FileOutputStream;
    .local v2, "fos":Ljava/io/FileOutputStream;
    :try_start_1
    new-instance v4, Ljava/io/PrintWriter;

    new-instance v5, Ljava/io/OutputStreamWriter;

    invoke-direct {v5, v2}, Ljava/io/OutputStreamWriter;-><init>(Ljava/io/OutputStream;)V

    invoke-direct {v4, v5}, Ljava/io/PrintWriter;-><init>(Ljava/io/Writer;)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1

    .line 232
    .end local v3    # "outStream":Ljava/io/PrintWriter;
    .local v4, "outStream":Ljava/io/PrintWriter;
    :try_start_2
    invoke-virtual {v4, p1}, Ljava/io/PrintWriter;->print(I)V

    .line 233
    invoke-virtual {v4}, Ljava/io/PrintWriter;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_2

    move-object v1, v2

    .end local v2    # "fos":Ljava/io/FileOutputStream;
    .restart local v1    # "fos":Ljava/io/FileOutputStream;
    move-object v3, v4

    .line 239
    .end local v4    # "outStream":Ljava/io/PrintWriter;
    .restart local v3    # "outStream":Ljava/io/PrintWriter;
    :goto_0
    return-void

    .line 234
    :catch_0
    move-exception v0

    .line 236
    .local v0, "e":Ljava/io/IOException;
    :goto_1
    const-string v5, "QcAppProfile"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "writeSysFile filepath"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " exception: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 234
    .end local v0    # "e":Ljava/io/IOException;
    .end local v1    # "fos":Ljava/io/FileOutputStream;
    .restart local v2    # "fos":Ljava/io/FileOutputStream;
    :catch_1
    move-exception v0

    move-object v1, v2

    .end local v2    # "fos":Ljava/io/FileOutputStream;
    .restart local v1    # "fos":Ljava/io/FileOutputStream;
    goto :goto_1

    .end local v1    # "fos":Ljava/io/FileOutputStream;
    .end local v3    # "outStream":Ljava/io/PrintWriter;
    .restart local v2    # "fos":Ljava/io/FileOutputStream;
    .restart local v4    # "outStream":Ljava/io/PrintWriter;
    :catch_2
    move-exception v0

    move-object v1, v2

    .end local v2    # "fos":Ljava/io/FileOutputStream;
    .restart local v1    # "fos":Ljava/io/FileOutputStream;
    move-object v3, v4

    .end local v4    # "outStream":Ljava/io/PrintWriter;
    .restart local v3    # "outStream":Ljava/io/PrintWriter;
    goto :goto_1
.end method


# virtual methods
.method public setAppProfile(Ljava/lang/String;)V
    .locals 4
    .param p1, "packageName"    # Ljava/lang/String;

    .prologue
    .line 331
    const/4 v0, 0x0

    .line 332
    .local v0, "retMode":I
    const-string v1, "QcAppProfile"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "App Profiles packageName:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 334
    invoke-direct {p0, p1}, Lcom/qualcomm/appProfile/QcAppProfileService;->setAppProfileTskin(Ljava/lang/String;)V

    .line 336
    const-string v1, "persist.sys.tskin"

    const/4 v2, 0x0

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->getInt(Ljava/lang/String;I)I

    move-result v0

    .line 337
    if-eqz v0, :cond_0

    .line 339
    invoke-direct {p0, p1, v0}, Lcom/qualcomm/appProfile/QcAppProfileService;->setAppProfilePowerMode(Ljava/lang/String;I)V

    .line 341
    :cond_0
    return-void
.end method
