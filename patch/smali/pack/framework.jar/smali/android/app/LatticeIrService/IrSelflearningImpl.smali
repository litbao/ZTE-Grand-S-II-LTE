.class public Landroid/app/LatticeIrService/IrSelflearningImpl;
.super Ljava/lang/Object;
.source "IrSelflearningImpl.java"

# interfaces
.implements Landroid/app/LatticeIrService/IrSelflearning;


# static fields
.field private static final MAX_XMIT_BUFFER:I = 0x1000

.field private static final TAG:Ljava/lang/String; = "LatticeIrService"


# instance fields
.field private DeviceInit_done:Z

.field private err:I

.field private final mHal:I

.field private final mHalLock:Ljava/lang/Object;


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 36
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 33
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->mHalLock:Ljava/lang/Object;

    .line 34
    iput-boolean v1, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->DeviceInit_done:Z

    .line 37
    iput-boolean v1, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->DeviceInit_done:Z

    .line 38
    invoke-static {}, Landroid/app/LatticeIrService/IrSelflearningImpl;->Openirslf_hal()I

    move-result v0

    iput v0, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->mHal:I

    .line 39
    iget v0, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->mHal:I

    if-nez v0, :cond_0

    .line 42
    :cond_0
    return-void
.end method

.method private static native Openirslf_hal()I
.end method

.method private static native halDeviceExit(I)I
.end method

.method private static native halDeviceInit(I)I
.end method

.method private static native halGetLearningStatus(I)I
.end method

.method private static native halPowerOff(I)I
.end method

.method private static native halPowerOn(I)I
.end method

.method private static native halReadIRCode(I)[I
.end method

.method private static native halReadIRFrequency(I)I
.end method

.method private static native halStartLearning(I)I
.end method

.method private static native halStopLearning(I)I
.end method

.method private static native halself_learning_support(I)I
.end method

.method private static native halsendIR(II[I)I
.end method

.method private throwifNoLatticehal()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/app/LatticeIrService/IrSLearingException;
        }
    .end annotation

    .prologue
    .line 45
    iget v0, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->mHal:I

    if-nez v0, :cond_0

    .line 46
    new-instance v0, Landroid/app/LatticeIrService/IrSLearingException;

    const-string v1, "Lattice IR Service, HAL not loaded"

    invoke-direct {v0, v1}, Landroid/app/LatticeIrService/IrSLearingException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 47
    :cond_0
    iget-boolean v0, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->DeviceInit_done:Z

    if-nez v0, :cond_1

    .line 48
    new-instance v0, Landroid/app/LatticeIrService/IrSLearingException;

    const-string v1, "DeviceInit function is not called first or DeviceInit function returned with some failure"

    invoke-direct {v0, v1}, Landroid/app/LatticeIrService/IrSLearingException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 50
    :cond_1
    return-void
.end method


# virtual methods
.method public DeviceExit()Z
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/app/LatticeIrService/IrSLearingException;
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    .line 124
    invoke-direct {p0}, Landroid/app/LatticeIrService/IrSelflearningImpl;->throwifNoLatticehal()V

    .line 126
    iput-boolean v0, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->DeviceInit_done:Z

    .line 128
    iget-object v1, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->mHalLock:Ljava/lang/Object;

    monitor-enter v1

    .line 129
    :try_start_0
    iget v2, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->mHal:I

    invoke-static {v2}, Landroid/app/LatticeIrService/IrSelflearningImpl;->halDeviceExit(I)I

    move-result v2

    iput v2, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->err:I

    .line 131
    iget v2, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->err:I

    if-gez v2, :cond_0

    .line 132
    const-string v2, "LatticeIrService"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Error halDeviceExit() : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->err:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 134
    :cond_0
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 135
    iget v1, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->err:I

    if-nez v1, :cond_1

    const/4 v0, 0x1

    :cond_1
    return v0

    .line 134
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method public DeviceInit()Z
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/app/LatticeIrService/IrSLearingException;
        }
    .end annotation

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 104
    iput-boolean v0, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->DeviceInit_done:Z

    .line 106
    invoke-direct {p0}, Landroid/app/LatticeIrService/IrSelflearningImpl;->throwifNoLatticehal()V

    .line 108
    iget-object v2, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->mHalLock:Ljava/lang/Object;

    monitor-enter v2

    .line 110
    :try_start_0
    iget v3, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->mHal:I

    invoke-static {v3}, Landroid/app/LatticeIrService/IrSelflearningImpl;->halDeviceInit(I)I

    move-result v3

    iput v3, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->err:I

    .line 111
    iget v3, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->err:I

    if-gez v3, :cond_0

    .line 112
    const/4 v0, 0x0

    iput-boolean v0, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->DeviceInit_done:Z

    .line 113
    const-string v0, "LatticeIrService"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Error DeviceInit() : "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v3, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->err:I

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 114
    new-instance v0, Landroid/app/LatticeIrService/IrSLearingException;

    const-string v1, "DeviceInit function failed, check the logcat for more info"

    invoke-direct {v0, v1}, Landroid/app/LatticeIrService/IrSLearingException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 117
    :catchall_0
    move-exception v0

    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0

    :cond_0
    :try_start_1
    monitor-exit v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 118
    iget v2, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->err:I

    if-nez v2, :cond_1

    :goto_0
    return v0

    :cond_1
    move v0, v1

    goto :goto_0
.end method

.method public GetLearningStatus()Z
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/app/LatticeIrService/IrSLearingException;
        }
    .end annotation

    .prologue
    const/4 v0, 0x1

    .line 202
    invoke-direct {p0}, Landroid/app/LatticeIrService/IrSelflearningImpl;->throwifNoLatticehal()V

    .line 204
    iget-object v1, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->mHalLock:Ljava/lang/Object;

    monitor-enter v1

    .line 205
    :try_start_0
    iget v2, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->mHal:I

    invoke-static {v2}, Landroid/app/LatticeIrService/IrSelflearningImpl;->halGetLearningStatus(I)I

    move-result v2

    iput v2, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->err:I

    .line 206
    iget v2, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->err:I

    if-gez v2, :cond_0

    .line 207
    const-string v2, "LatticeIrService"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Error GetLearningStatus() : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->err:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 210
    :cond_0
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 211
    iget v1, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->err:I

    if-ne v1, v0, :cond_1

    :goto_0
    return v0

    .line 210
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0

    .line 211
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public PowerOff()Z
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/app/LatticeIrService/IrSLearingException;
        }
    .end annotation

    .prologue
    .line 89
    invoke-direct {p0}, Landroid/app/LatticeIrService/IrSelflearningImpl;->throwifNoLatticehal()V

    .line 91
    iget-object v1, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->mHalLock:Ljava/lang/Object;

    monitor-enter v1

    .line 92
    :try_start_0
    iget v0, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->mHal:I

    invoke-static {v0}, Landroid/app/LatticeIrService/IrSelflearningImpl;->halPowerOff(I)I

    move-result v0

    iput v0, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->err:I

    .line 94
    iget v0, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->err:I

    if-gez v0, :cond_0

    .line 95
    const-string v0, "LatticeIrService"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Error halPoweroff() : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->err:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 97
    :cond_0
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 98
    iget v0, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->err:I

    if-nez v0, :cond_1

    const/4 v0, 0x1

    :goto_0
    return v0

    .line 97
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0

    .line 98
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public PowerOn()Z
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/app/LatticeIrService/IrSLearingException;
        }
    .end annotation

    .prologue
    .line 74
    invoke-direct {p0}, Landroid/app/LatticeIrService/IrSelflearningImpl;->throwifNoLatticehal()V

    .line 76
    iget-object v1, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->mHalLock:Ljava/lang/Object;

    monitor-enter v1

    .line 77
    :try_start_0
    iget v0, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->mHal:I

    invoke-static {v0}, Landroid/app/LatticeIrService/IrSelflearningImpl;->halPowerOn(I)I

    move-result v0

    iput v0, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->err:I

    .line 79
    iget v0, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->err:I

    if-gez v0, :cond_0

    .line 80
    const-string v0, "LatticeIrService"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Error halPoweron() : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->err:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 82
    :cond_0
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 83
    iget v0, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->err:I

    if-nez v0, :cond_1

    const/4 v0, 0x1

    :goto_0
    return v0

    .line 82
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0

    .line 83
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public ReadIRCode()[I
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/app/LatticeIrService/IrSLearingException;
        }
    .end annotation

    .prologue
    .line 232
    invoke-direct {p0}, Landroid/app/LatticeIrService/IrSelflearningImpl;->throwifNoLatticehal()V

    .line 234
    iget-object v1, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->mHalLock:Ljava/lang/Object;

    monitor-enter v1

    .line 235
    :try_start_0
    iget v0, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->mHal:I

    invoke-static {v0}, Landroid/app/LatticeIrService/IrSelflearningImpl;->halReadIRCode(I)[I

    move-result-object v0

    monitor-exit v1

    return-object v0

    .line 236
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public ReadIRFrequency()I
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/app/LatticeIrService/IrSLearingException;
        }
    .end annotation

    .prologue
    .line 217
    invoke-direct {p0}, Landroid/app/LatticeIrService/IrSelflearningImpl;->throwifNoLatticehal()V

    .line 219
    iget-object v1, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->mHalLock:Ljava/lang/Object;

    monitor-enter v1

    .line 220
    :try_start_0
    iget v0, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->mHal:I

    invoke-static {v0}, Landroid/app/LatticeIrService/IrSelflearningImpl;->halReadIRFrequency(I)I

    move-result v0

    iput v0, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->err:I

    .line 222
    iget v0, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->err:I

    if-gez v0, :cond_0

    .line 223
    const-string v0, "LatticeIrService"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Error halReadIRFrequency : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->err:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 225
    :cond_0
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 226
    iget v0, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->err:I

    return v0

    .line 225
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method public StartLearning()Z
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/app/LatticeIrService/IrSLearingException;
        }
    .end annotation

    .prologue
    .line 171
    invoke-direct {p0}, Landroid/app/LatticeIrService/IrSelflearningImpl;->throwifNoLatticehal()V

    .line 173
    iget-object v1, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->mHalLock:Ljava/lang/Object;

    monitor-enter v1

    .line 174
    :try_start_0
    iget v0, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->mHal:I

    invoke-static {v0}, Landroid/app/LatticeIrService/IrSelflearningImpl;->halStartLearning(I)I

    move-result v0

    iput v0, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->err:I

    .line 176
    iget v0, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->err:I

    if-gez v0, :cond_0

    .line 177
    const-string v0, "LatticeIrService"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Error halStartLearning() : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->err:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 179
    :cond_0
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 180
    iget v0, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->err:I

    if-nez v0, :cond_1

    const/4 v0, 0x1

    :goto_0
    return v0

    .line 179
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0

    .line 180
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public StopLearning()Z
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/app/LatticeIrService/IrSLearingException;
        }
    .end annotation

    .prologue
    .line 187
    invoke-direct {p0}, Landroid/app/LatticeIrService/IrSelflearningImpl;->throwifNoLatticehal()V

    .line 189
    iget-object v1, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->mHalLock:Ljava/lang/Object;

    monitor-enter v1

    .line 190
    :try_start_0
    iget v0, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->mHal:I

    invoke-static {v0}, Landroid/app/LatticeIrService/IrSelflearningImpl;->halStopLearning(I)I

    move-result v0

    iput v0, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->err:I

    .line 192
    iget v0, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->err:I

    if-gez v0, :cond_0

    .line 193
    const-string v0, "LatticeIrService"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Error halStopLearning() : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->err:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 195
    :cond_0
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 196
    iget v0, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->err:I

    if-nez v0, :cond_1

    const/4 v0, 0x1

    :goto_0
    return v0

    .line 195
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0

    .line 196
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hasIrSelfLearning()Z
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/app/LatticeIrService/IrSLearingException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x1

    .line 61
    iget-boolean v0, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->DeviceInit_done:Z

    .line 63
    .local v0, "DeviceInit_done_temp":Z
    iput-boolean v1, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->DeviceInit_done:Z

    .line 64
    invoke-direct {p0}, Landroid/app/LatticeIrService/IrSelflearningImpl;->throwifNoLatticehal()V

    .line 65
    iput-boolean v0, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->DeviceInit_done:Z

    .line 67
    iget v2, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->mHal:I

    invoke-static {v2}, Landroid/app/LatticeIrService/IrSelflearningImpl;->halself_learning_support(I)I

    move-result v2

    if-ne v2, v1, :cond_0

    :goto_0
    return v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public hasLatticeIrService()Z
    .locals 1

    .prologue
    .line 55
    iget v0, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->mHal:I

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public transmit(I[I)Z
    .locals 10
    .param p1, "carrierFrequency"    # I
    .param p2, "pattern"    # [I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/app/LatticeIrService/IrSLearingException;
        }
    .end annotation

    .prologue
    .line 142
    const-wide/16 v4, 0x0

    .line 144
    .local v4, "totalXmitbyte":J
    move-object v0, p2

    .local v0, "arr$":[I
    array-length v2, v0

    .local v2, "len$":I
    const/4 v1, 0x0

    .local v1, "i$":I
    :goto_0
    if-ge v1, v2, :cond_1

    aget v3, v0, v1

    .line 145
    .local v3, "slice":I
    if-gtz v3, :cond_0

    .line 146
    new-instance v6, Ljava/lang/IllegalArgumentException;

    const-string v7, "Non-positive IR slice"

    invoke-direct {v6, v7}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v6

    .line 148
    :cond_0
    const-wide/16 v6, 0x2

    add-long/2addr v4, v6

    .line 144
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 151
    .end local v3    # "slice":I
    :cond_1
    const-wide/16 v6, 0x1000

    cmp-long v6, v4, v6

    if-lez v6, :cond_2

    .line 152
    new-instance v6, Ljava/lang/IllegalArgumentException;

    const-string v7, "IR pattern too long"

    invoke-direct {v6, v7}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v6

    .line 155
    :cond_2
    invoke-direct {p0}, Landroid/app/LatticeIrService/IrSelflearningImpl;->throwifNoLatticehal()V

    .line 158
    iget-object v7, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->mHalLock:Ljava/lang/Object;

    monitor-enter v7

    .line 159
    :try_start_0
    iget v6, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->mHal:I

    invoke-static {v6, p1, p2}, Landroid/app/LatticeIrService/IrSelflearningImpl;->halsendIR(II[I)I

    move-result v6

    iput v6, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->err:I

    .line 160
    iget v6, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->err:I

    if-gez v6, :cond_3

    .line 161
    const-string v6, "LatticeIrService"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "Error transmitting: "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    iget v9, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->err:I

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v6, v8}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 163
    :cond_3
    monitor-exit v7
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 165
    iget v6, p0, Landroid/app/LatticeIrService/IrSelflearningImpl;->err:I

    if-nez v6, :cond_4

    const/4 v6, 0x1

    :goto_1
    return v6

    .line 163
    :catchall_0
    move-exception v6

    :try_start_1
    monitor-exit v7
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v6

    .line 165
    :cond_4
    const/4 v6, 0x0

    goto :goto_1
.end method
