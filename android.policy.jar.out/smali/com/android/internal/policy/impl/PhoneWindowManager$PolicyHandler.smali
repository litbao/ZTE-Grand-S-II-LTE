.class Lcom/android/internal/policy/impl/PhoneWindowManager$PolicyHandler;
.super Landroid/os/Handler;
.source "PhoneWindowManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/internal/policy/impl/PhoneWindowManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "PolicyHandler"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/android/internal/policy/impl/PhoneWindowManager;


# direct methods
.method private constructor <init>(Lcom/android/internal/policy/impl/PhoneWindowManager;)V
    .locals 0

    .prologue
    .line 716
    iput-object p1, p0, Lcom/android/internal/policy/impl/PhoneWindowManager$PolicyHandler;->this$0:Lcom/android/internal/policy/impl/PhoneWindowManager;

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/android/internal/policy/impl/PhoneWindowManager;Lcom/android/internal/policy/impl/PhoneWindowManager$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/android/internal/policy/impl/PhoneWindowManager;
    .param p2, "x1"    # Lcom/android/internal/policy/impl/PhoneWindowManager$1;

    .prologue
    .line 716
    invoke-direct {p0, p1}, Lcom/android/internal/policy/impl/PhoneWindowManager$PolicyHandler;-><init>(Lcom/android/internal/policy/impl/PhoneWindowManager;)V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 8
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/4 v3, 0x0

    const/4 v2, 0x1

    .line 719
    iget v1, p1, Landroid/os/Message;->what:I

    packed-switch v1, :pswitch_data_0

    .line 777
    :goto_0
    :pswitch_0
    return-void

    .line 721
    :pswitch_1
    iget-object v1, p0, Lcom/android/internal/policy/impl/PhoneWindowManager$PolicyHandler;->this$0:Lcom/android/internal/policy/impl/PhoneWindowManager;

    # invokes: Lcom/android/internal/policy/impl/PhoneWindowManager;->enablePointerLocation()V
    invoke-static {v1}, Lcom/android/internal/policy/impl/PhoneWindowManager;->access$000(Lcom/android/internal/policy/impl/PhoneWindowManager;)V

    goto :goto_0

    .line 724
    :pswitch_2
    iget-object v1, p0, Lcom/android/internal/policy/impl/PhoneWindowManager$PolicyHandler;->this$0:Lcom/android/internal/policy/impl/PhoneWindowManager;

    # invokes: Lcom/android/internal/policy/impl/PhoneWindowManager;->disablePointerLocation()V
    invoke-static {v1}, Lcom/android/internal/policy/impl/PhoneWindowManager;->access$100(Lcom/android/internal/policy/impl/PhoneWindowManager;)V

    goto :goto_0

    .line 727
    :pswitch_3
    iget-object v2, p0, Lcom/android/internal/policy/impl/PhoneWindowManager$PolicyHandler;->this$0:Lcom/android/internal/policy/impl/PhoneWindowManager;

    iget-object v1, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v1, Landroid/view/KeyEvent;

    invoke-virtual {v2, v1}, Lcom/android/internal/policy/impl/PhoneWindowManager;->dispatchMediaKeyWithWakeLock(Landroid/view/KeyEvent;)V

    goto :goto_0

    .line 730
    :pswitch_4
    iget-object v2, p0, Lcom/android/internal/policy/impl/PhoneWindowManager$PolicyHandler;->this$0:Lcom/android/internal/policy/impl/PhoneWindowManager;

    iget-object v1, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v1, Landroid/view/KeyEvent;

    invoke-virtual {v2, v1}, Lcom/android/internal/policy/impl/PhoneWindowManager;->dispatchMediaKeyRepeatWithWakeLock(Landroid/view/KeyEvent;)V

    goto :goto_0

    .line 733
    :pswitch_5
    iget-object v1, p0, Lcom/android/internal/policy/impl/PhoneWindowManager$PolicyHandler;->this$0:Lcom/android/internal/policy/impl/PhoneWindowManager;

    # invokes: Lcom/android/internal/policy/impl/PhoneWindowManager;->showRecentApps(Z)V
    invoke-static {v1, v3}, Lcom/android/internal/policy/impl/PhoneWindowManager;->access$200(Lcom/android/internal/policy/impl/PhoneWindowManager;Z)V

    goto :goto_0

    .line 736
    :pswitch_6
    iget-object v1, p0, Lcom/android/internal/policy/impl/PhoneWindowManager$PolicyHandler;->this$0:Lcom/android/internal/policy/impl/PhoneWindowManager;

    invoke-virtual {v1}, Lcom/android/internal/policy/impl/PhoneWindowManager;->showGlobalActionsInternal()V

    goto :goto_0

    .line 739
    :pswitch_7
    const-string v1, "WindowManager"

    const-string v2, "Setting mKeyguardDrawComplete"

    invoke-static {v1, v2}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 740
    iget-object v1, p0, Lcom/android/internal/policy/impl/PhoneWindowManager$PolicyHandler;->this$0:Lcom/android/internal/policy/impl/PhoneWindowManager;

    # invokes: Lcom/android/internal/policy/impl/PhoneWindowManager;->finishKeyguardDrawn()V
    invoke-static {v1}, Lcom/android/internal/policy/impl/PhoneWindowManager;->access$300(Lcom/android/internal/policy/impl/PhoneWindowManager;)V

    goto :goto_0

    .line 743
    :pswitch_8
    const-string v1, "WindowManager"

    const-string v2, "Keyguard drawn timeout. Setting mKeyguardDrawComplete"

    invoke-static {v1, v2}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 744
    iget-object v1, p0, Lcom/android/internal/policy/impl/PhoneWindowManager$PolicyHandler;->this$0:Lcom/android/internal/policy/impl/PhoneWindowManager;

    # invokes: Lcom/android/internal/policy/impl/PhoneWindowManager;->finishKeyguardDrawn()V
    invoke-static {v1}, Lcom/android/internal/policy/impl/PhoneWindowManager;->access$300(Lcom/android/internal/policy/impl/PhoneWindowManager;)V

    goto :goto_0

    .line 747
    :pswitch_9
    const-string v1, "WindowManager"

    const-string v2, "Setting mWindowManagerDrawComplete"

    invoke-static {v1, v2}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 748
    iget-object v1, p0, Lcom/android/internal/policy/impl/PhoneWindowManager$PolicyHandler;->this$0:Lcom/android/internal/policy/impl/PhoneWindowManager;

    # invokes: Lcom/android/internal/policy/impl/PhoneWindowManager;->finishWindowsDrawn()V
    invoke-static {v1}, Lcom/android/internal/policy/impl/PhoneWindowManager;->access$400(Lcom/android/internal/policy/impl/PhoneWindowManager;)V

    goto :goto_0

    .line 751
    :pswitch_a
    iget-object v1, p0, Lcom/android/internal/policy/impl/PhoneWindowManager$PolicyHandler;->this$0:Lcom/android/internal/policy/impl/PhoneWindowManager;

    # invokes: Lcom/android/internal/policy/impl/PhoneWindowManager;->handleHideBootMessage()V
    invoke-static {v1}, Lcom/android/internal/policy/impl/PhoneWindowManager;->access$500(Lcom/android/internal/policy/impl/PhoneWindowManager;)V

    goto :goto_0

    .line 754
    :pswitch_b
    iget-object v4, p0, Lcom/android/internal/policy/impl/PhoneWindowManager$PolicyHandler;->this$0:Lcom/android/internal/policy/impl/PhoneWindowManager;

    iget v1, p1, Landroid/os/Message;->arg1:I

    if-eqz v1, :cond_0

    move v1, v2

    :goto_1
    invoke-virtual {v4, v1}, Lcom/android/internal/policy/impl/PhoneWindowManager;->launchVoiceAssistWithWakeLock(Z)V

    goto :goto_0

    :cond_0
    move v1, v3

    goto :goto_1

    .line 757
    :pswitch_c
    iget-object v4, p0, Lcom/android/internal/policy/impl/PhoneWindowManager$PolicyHandler;->this$0:Lcom/android/internal/policy/impl/PhoneWindowManager;

    iget-object v1, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v1, Ljava/lang/Long;

    invoke-virtual {v1}, Ljava/lang/Long;->longValue()J

    move-result-wide v6

    iget v1, p1, Landroid/os/Message;->arg1:I

    if-eqz v1, :cond_1

    :goto_2
    iget v1, p1, Landroid/os/Message;->arg2:I

    # invokes: Lcom/android/internal/policy/impl/PhoneWindowManager;->powerPress(JZI)V
    invoke-static {v4, v6, v7, v2, v1}, Lcom/android/internal/policy/impl/PhoneWindowManager;->access$600(Lcom/android/internal/policy/impl/PhoneWindowManager;JZI)V

    .line 758
    iget-object v1, p0, Lcom/android/internal/policy/impl/PhoneWindowManager$PolicyHandler;->this$0:Lcom/android/internal/policy/impl/PhoneWindowManager;

    # invokes: Lcom/android/internal/policy/impl/PhoneWindowManager;->finishPowerKeyPress()V
    invoke-static {v1}, Lcom/android/internal/policy/impl/PhoneWindowManager;->access$700(Lcom/android/internal/policy/impl/PhoneWindowManager;)V

    goto :goto_0

    :cond_1
    move v2, v3

    .line 757
    goto :goto_2

    .line 761
    :pswitch_d
    iget-object v1, p0, Lcom/android/internal/policy/impl/PhoneWindowManager$PolicyHandler;->this$0:Lcom/android/internal/policy/impl/PhoneWindowManager;

    # invokes: Lcom/android/internal/policy/impl/PhoneWindowManager;->powerLongPress()V
    invoke-static {v1}, Lcom/android/internal/policy/impl/PhoneWindowManager;->access$800(Lcom/android/internal/policy/impl/PhoneWindowManager;)V

    goto/16 :goto_0

    .line 764
    :pswitch_e
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/view/KeyEvent;

    .line 765
    .local v0, "event":Landroid/view/KeyEvent;
    iget-object v1, p0, Lcom/android/internal/policy/impl/PhoneWindowManager$PolicyHandler;->this$0:Lcom/android/internal/policy/impl/PhoneWindowManager;

    iput-boolean v2, v1, Lcom/android/internal/policy/impl/PhoneWindowManager;->mIsLongPress:Z

    .line 766
    iget-object v1, p0, Lcom/android/internal/policy/impl/PhoneWindowManager$PolicyHandler;->this$0:Lcom/android/internal/policy/impl/PhoneWindowManager;

    invoke-virtual {v1, v0}, Lcom/android/internal/policy/impl/PhoneWindowManager;->dispatchMediaKeyWithWakeLockToAudioService(Landroid/view/KeyEvent;)V

    .line 767
    iget-object v1, p0, Lcom/android/internal/policy/impl/PhoneWindowManager$PolicyHandler;->this$0:Lcom/android/internal/policy/impl/PhoneWindowManager;

    invoke-static {v0, v2}, Landroid/view/KeyEvent;->changeAction(Landroid/view/KeyEvent;I)Landroid/view/KeyEvent;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/android/internal/policy/impl/PhoneWindowManager;->dispatchMediaKeyWithWakeLockToAudioService(Landroid/view/KeyEvent;)V

    goto/16 :goto_0

    .line 772
    .end local v0    # "event":Landroid/view/KeyEvent;
    :pswitch_f
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/view/KeyEvent;

    .line 773
    .restart local v0    # "event":Landroid/view/KeyEvent;
    iget-object v1, p0, Lcom/android/internal/policy/impl/PhoneWindowManager$PolicyHandler;->this$0:Lcom/android/internal/policy/impl/PhoneWindowManager;

    iput-boolean v2, v1, Lcom/android/internal/policy/impl/PhoneWindowManager;->mIsLongPress:Z

    goto/16 :goto_0

    .line 719
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
        :pswitch_7
        :pswitch_8
        :pswitch_9
        :pswitch_0
        :pswitch_5
        :pswitch_6
        :pswitch_a
        :pswitch_b
        :pswitch_c
        :pswitch_d
        :pswitch_e
        :pswitch_f
    .end packed-switch
.end method
