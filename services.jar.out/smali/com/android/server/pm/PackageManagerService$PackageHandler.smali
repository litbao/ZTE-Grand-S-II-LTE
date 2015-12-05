.class Lcom/android/server/pm/PackageManagerService$PackageHandler;
.super Landroid/os/Handler;
.source "PackageManagerService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/server/pm/PackageManagerService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "PackageHandler"
.end annotation


# instance fields
.field private mBound:Z

.field final mPendingInstalls:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/android/server/pm/PackageManagerService$HandlerParams;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic this$0:Lcom/android/server/pm/PackageManagerService;


# direct methods
.method constructor <init>(Lcom/android/server/pm/PackageManagerService;Landroid/os/Looper;)V
    .locals 1
    .param p2, "looper"    # Landroid/os/Looper;

    .prologue
    .line 858
    iput-object p1, p0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    .line 859
    invoke-direct {p0, p2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    .line 831
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->mBound:Z

    .line 832
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->mPendingInstalls:Ljava/util/ArrayList;

    .line 860
    return-void
.end method

.method private connectToService()Z
    .locals 7

    .prologue
    const/16 v6, 0xa

    const/4 v2, 0x0

    const/4 v1, 0x1

    .line 838
    new-instance v3, Landroid/content/Intent;

    invoke-direct {v3}, Landroid/content/Intent;-><init>()V

    sget-object v4, Lcom/android/server/pm/PackageManagerService;->DEFAULT_CONTAINER_COMPONENT:Landroid/content/ComponentName;

    invoke-virtual {v3, v4}, Landroid/content/Intent;->setComponent(Landroid/content/ComponentName;)Landroid/content/Intent;

    move-result-object v0

    .line 839
    .local v0, "service":Landroid/content/Intent;
    invoke-static {v2}, Landroid/os/Process;->setThreadPriority(I)V

    .line 840
    iget-object v3, p0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    iget-object v3, v3, Lcom/android/server/pm/PackageManagerService;->mContext:Landroid/content/Context;

    iget-object v4, p0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    # getter for: Lcom/android/server/pm/PackageManagerService;->mDefContainerConn:Lcom/android/server/pm/PackageManagerService$DefaultContainerConnection;
    invoke-static {v4}, Lcom/android/server/pm/PackageManagerService;->access$500(Lcom/android/server/pm/PackageManagerService;)Lcom/android/server/pm/PackageManagerService$DefaultContainerConnection;

    move-result-object v4

    sget-object v5, Landroid/os/UserHandle;->OWNER:Landroid/os/UserHandle;

    invoke-virtual {v3, v0, v4, v1, v5}, Landroid/content/Context;->bindServiceAsUser(Landroid/content/Intent;Landroid/content/ServiceConnection;ILandroid/os/UserHandle;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 842
    invoke-static {v6}, Landroid/os/Process;->setThreadPriority(I)V

    .line 843
    iput-boolean v1, p0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->mBound:Z

    .line 847
    :goto_0
    return v1

    .line 846
    :cond_0
    invoke-static {v6}, Landroid/os/Process;->setThreadPriority(I)V

    move v1, v2

    .line 847
    goto :goto_0
.end method

.method private disconnectService()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 851
    iget-object v0, p0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    const/4 v1, 0x0

    # setter for: Lcom/android/server/pm/PackageManagerService;->mContainerService:Lcom/android/internal/app/IMediaContainerService;
    invoke-static {v0, v1}, Lcom/android/server/pm/PackageManagerService;->access$602(Lcom/android/server/pm/PackageManagerService;Lcom/android/internal/app/IMediaContainerService;)Lcom/android/internal/app/IMediaContainerService;

    .line 852
    iput-boolean v2, p0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->mBound:Z

    .line 853
    invoke-static {v2}, Landroid/os/Process;->setThreadPriority(I)V

    .line 854
    iget-object v0, p0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    iget-object v0, v0, Lcom/android/server/pm/PackageManagerService;->mContext:Landroid/content/Context;

    iget-object v1, p0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    # getter for: Lcom/android/server/pm/PackageManagerService;->mDefContainerConn:Lcom/android/server/pm/PackageManagerService$DefaultContainerConnection;
    invoke-static {v1}, Lcom/android/server/pm/PackageManagerService;->access$500(Lcom/android/server/pm/PackageManagerService;)Lcom/android/server/pm/PackageManagerService$DefaultContainerConnection;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/content/Context;->unbindService(Landroid/content/ServiceConnection;)V

    .line 855
    const/16 v0, 0xa

    invoke-static {v0}, Landroid/os/Process;->setThreadPriority(I)V

    .line 856
    return-void
.end method


# virtual methods
.method doHandleMessage(Landroid/os/Message;)V
    .locals 65
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    .line 871
    move-object/from16 v0, p1

    iget v4, v0, Landroid/os/Message;->what:I

    packed-switch v4, :pswitch_data_0

    .line 1310
    :cond_0
    :goto_0
    :pswitch_0
    return-void

    .line 873
    :pswitch_1
    move-object/from16 v0, p1

    iget-object v0, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    move-object/from16 v49, v0

    check-cast v49, Lcom/android/server/pm/PackageManagerService$HandlerParams;

    .line 874
    .local v49, "params":Lcom/android/server/pm/PackageManagerService$HandlerParams;
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->mPendingInstalls:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v37

    .line 879
    .local v37, "idx":I
    move-object/from16 v0, p0

    iget-boolean v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->mBound:Z

    if-nez v4, :cond_2

    .line 882
    invoke-direct/range {p0 .. p0}, Lcom/android/server/pm/PackageManagerService$PackageHandler;->connectToService()Z

    move-result v4

    if-nez v4, :cond_1

    .line 883
    const-string v4, "PackageManager"

    const-string v5, "Failed to bind to media container service"

    invoke-static {v4, v5}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 884
    invoke-virtual/range {v49 .. v49}, Lcom/android/server/pm/PackageManagerService$HandlerParams;->serviceError()V

    goto :goto_0

    .line 889
    :cond_1
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->mPendingInstalls:Ljava/util/ArrayList;

    move/from16 v0, v37

    move-object/from16 v1, v49

    invoke-virtual {v4, v0, v1}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    goto :goto_0

    .line 892
    :cond_2
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->mPendingInstalls:Ljava/util/ArrayList;

    move/from16 v0, v37

    move-object/from16 v1, v49

    invoke-virtual {v4, v0, v1}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    .line 895
    if-nez v37, :cond_0

    .line 896
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    iget-object v4, v4, Lcom/android/server/pm/PackageManagerService;->mHandler:Lcom/android/server/pm/PackageManagerService$PackageHandler;

    const/4 v5, 0x3

    invoke-virtual {v4, v5}, Lcom/android/server/pm/PackageManagerService$PackageHandler;->sendEmptyMessage(I)Z

    goto :goto_0

    .line 903
    .end local v37    # "idx":I
    .end local v49    # "params":Lcom/android/server/pm/PackageManagerService$HandlerParams;
    :pswitch_2
    move-object/from16 v0, p1

    iget-object v4, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    if-eqz v4, :cond_3

    .line 904
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    move-object/from16 v0, p1

    iget-object v4, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v4, Lcom/android/internal/app/IMediaContainerService;

    # setter for: Lcom/android/server/pm/PackageManagerService;->mContainerService:Lcom/android/internal/app/IMediaContainerService;
    invoke-static {v5, v4}, Lcom/android/server/pm/PackageManagerService;->access$602(Lcom/android/server/pm/PackageManagerService;Lcom/android/internal/app/IMediaContainerService;)Lcom/android/internal/app/IMediaContainerService;

    .line 906
    :cond_3
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    # getter for: Lcom/android/server/pm/PackageManagerService;->mContainerService:Lcom/android/internal/app/IMediaContainerService;
    invoke-static {v4}, Lcom/android/server/pm/PackageManagerService;->access$600(Lcom/android/server/pm/PackageManagerService;)Lcom/android/internal/app/IMediaContainerService;

    move-result-object v4

    if-nez v4, :cond_5

    .line 908
    const-string v4, "PackageManager"

    const-string v5, "Cannot bind to media container service"

    invoke-static {v4, v5}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 909
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->mPendingInstalls:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v36

    .local v36, "i$":Ljava/util/Iterator;
    :goto_1
    invoke-interface/range {v36 .. v36}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_4

    invoke-interface/range {v36 .. v36}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v49

    check-cast v49, Lcom/android/server/pm/PackageManagerService$HandlerParams;

    .line 911
    .restart local v49    # "params":Lcom/android/server/pm/PackageManagerService$HandlerParams;
    invoke-virtual/range {v49 .. v49}, Lcom/android/server/pm/PackageManagerService$HandlerParams;->serviceError()V

    goto :goto_1

    .line 913
    .end local v49    # "params":Lcom/android/server/pm/PackageManagerService$HandlerParams;
    :cond_4
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->mPendingInstalls:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->clear()V

    goto/16 :goto_0

    .line 914
    .end local v36    # "i$":Ljava/util/Iterator;
    :cond_5
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->mPendingInstalls:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v4

    if-lez v4, :cond_8

    .line 915
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->mPendingInstalls:Ljava/util/ArrayList;

    const/4 v5, 0x0

    invoke-virtual {v4, v5}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v49

    check-cast v49, Lcom/android/server/pm/PackageManagerService$HandlerParams;

    .line 916
    .restart local v49    # "params":Lcom/android/server/pm/PackageManagerService$HandlerParams;
    if-eqz v49, :cond_0

    .line 917
    invoke-virtual/range {v49 .. v49}, Lcom/android/server/pm/PackageManagerService$HandlerParams;->startCopy()Z

    move-result v4

    if-eqz v4, :cond_0

    .line 923
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->mPendingInstalls:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v4

    if-lez v4, :cond_6

    .line 924
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->mPendingInstalls:Ljava/util/ArrayList;

    const/4 v5, 0x0

    invoke-virtual {v4, v5}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    .line 926
    :cond_6
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->mPendingInstalls:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v4

    if-nez v4, :cond_7

    .line 927
    move-object/from16 v0, p0

    iget-boolean v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->mBound:Z

    if-eqz v4, :cond_0

    .line 930
    const/4 v4, 0x6

    move-object/from16 v0, p0

    invoke-virtual {v0, v4}, Lcom/android/server/pm/PackageManagerService$PackageHandler;->removeMessages(I)V

    .line 931
    const/4 v4, 0x6

    move-object/from16 v0, p0

    invoke-virtual {v0, v4}, Lcom/android/server/pm/PackageManagerService$PackageHandler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v58

    .line 934
    .local v58, "ubmsg":Landroid/os/Message;
    const-wide/16 v4, 0x2710

    move-object/from16 v0, p0

    move-object/from16 v1, v58

    invoke-virtual {v0, v1, v4, v5}, Lcom/android/server/pm/PackageManagerService$PackageHandler;->sendMessageDelayed(Landroid/os/Message;J)Z

    goto/16 :goto_0

    .line 942
    .end local v58    # "ubmsg":Landroid/os/Message;
    :cond_7
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    iget-object v4, v4, Lcom/android/server/pm/PackageManagerService;->mHandler:Lcom/android/server/pm/PackageManagerService$PackageHandler;

    const/4 v5, 0x3

    invoke-virtual {v4, v5}, Lcom/android/server/pm/PackageManagerService$PackageHandler;->sendEmptyMessage(I)Z

    goto/16 :goto_0

    .line 948
    .end local v49    # "params":Lcom/android/server/pm/PackageManagerService$HandlerParams;
    :cond_8
    const-string v4, "PackageManager"

    const-string v5, "Empty queue"

    invoke-static {v4, v5}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 954
    :pswitch_3
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->mPendingInstalls:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v4

    if-lez v4, :cond_0

    .line 955
    move-object/from16 v0, p0

    iget-boolean v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->mBound:Z

    if-eqz v4, :cond_9

    .line 956
    invoke-direct/range {p0 .. p0}, Lcom/android/server/pm/PackageManagerService$PackageHandler;->disconnectService()V

    .line 958
    :cond_9
    invoke-direct/range {p0 .. p0}, Lcom/android/server/pm/PackageManagerService$PackageHandler;->connectToService()Z

    move-result v4

    if-nez v4, :cond_0

    .line 959
    const-string v4, "PackageManager"

    const-string v5, "Failed to bind to media container service"

    invoke-static {v4, v5}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 960
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->mPendingInstalls:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v36

    .restart local v36    # "i$":Ljava/util/Iterator;
    :goto_2
    invoke-interface/range {v36 .. v36}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_a

    invoke-interface/range {v36 .. v36}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v49

    check-cast v49, Lcom/android/server/pm/PackageManagerService$HandlerParams;

    .line 962
    .restart local v49    # "params":Lcom/android/server/pm/PackageManagerService$HandlerParams;
    invoke-virtual/range {v49 .. v49}, Lcom/android/server/pm/PackageManagerService$HandlerParams;->serviceError()V

    goto :goto_2

    .line 964
    .end local v49    # "params":Lcom/android/server/pm/PackageManagerService$HandlerParams;
    :cond_a
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->mPendingInstalls:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->clear()V

    goto/16 :goto_0

    .line 973
    .end local v36    # "i$":Ljava/util/Iterator;
    :pswitch_4
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->mPendingInstalls:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v4

    if-nez v4, :cond_b

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    iget-object v4, v4, Lcom/android/server/pm/PackageManagerService;->mPendingVerification:Landroid/util/SparseArray;

    invoke-virtual {v4}, Landroid/util/SparseArray;->size()I

    move-result v4

    if-nez v4, :cond_b

    .line 974
    move-object/from16 v0, p0

    iget-boolean v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->mBound:Z

    if-eqz v4, :cond_0

    .line 977
    invoke-direct/range {p0 .. p0}, Lcom/android/server/pm/PackageManagerService$PackageHandler;->disconnectService()V

    goto/16 :goto_0

    .line 979
    :cond_b
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->mPendingInstalls:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v4

    if-lez v4, :cond_0

    .line 983
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    iget-object v4, v4, Lcom/android/server/pm/PackageManagerService;->mHandler:Lcom/android/server/pm/PackageManagerService$PackageHandler;

    const/4 v5, 0x3

    invoke-virtual {v4, v5}, Lcom/android/server/pm/PackageManagerService$PackageHandler;->sendEmptyMessage(I)Z

    goto/16 :goto_0

    .line 990
    :pswitch_5
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->mPendingInstalls:Ljava/util/ArrayList;

    const/4 v5, 0x0

    invoke-virtual {v4, v5}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    goto/16 :goto_0

    .line 996
    :pswitch_6
    const/16 v56, 0x0

    .line 998
    .local v56, "size":I
    const/4 v4, 0x0

    invoke-static {v4}, Landroid/os/Process;->setThreadPriority(I)V

    .line 999
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    iget-object v5, v4, Lcom/android/server/pm/PackageManagerService;->mPackages:Landroid/util/ArrayMap;

    monitor-enter v5

    .line 1000
    :try_start_0
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    iget-object v4, v4, Lcom/android/server/pm/PackageManagerService;->mPendingBroadcasts:Lcom/android/server/pm/PackageManagerService$PendingPackageBroadcasts;

    if-nez v4, :cond_c

    .line 1001
    monitor-exit v5

    goto/16 :goto_0

    .line 1031
    :catchall_0
    move-exception v4

    monitor-exit v5
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v4

    .line 1003
    :cond_c
    :try_start_1
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    iget-object v4, v4, Lcom/android/server/pm/PackageManagerService;->mPendingBroadcasts:Lcom/android/server/pm/PackageManagerService$PendingPackageBroadcasts;

    invoke-virtual {v4}, Lcom/android/server/pm/PackageManagerService$PendingPackageBroadcasts;->size()I

    move-result v56

    .line 1004
    if-gtz v56, :cond_d

    .line 1006
    monitor-exit v5

    goto/16 :goto_0

    .line 1008
    :cond_d
    move/from16 v0, v56

    new-array v0, v0, [Ljava/lang/String;

    move-object/from16 v48, v0

    .line 1009
    .local v48, "packages":[Ljava/lang/String;
    move/from16 v0, v56

    new-array v0, v0, [Ljava/util/ArrayList;

    move-object/from16 v29, v0

    .line 1010
    .local v29, "components":[Ljava/util/ArrayList;, "[Ljava/util/ArrayList<Ljava/lang/String;>;"
    move/from16 v0, v56

    new-array v0, v0, [I

    move-object/from16 v59, v0

    .line 1011
    .local v59, "uids":[I
    const/16 v35, 0x0

    .line 1013
    .local v35, "i":I
    const/16 v42, 0x0

    .local v42, "n":I
    :goto_3
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    iget-object v4, v4, Lcom/android/server/pm/PackageManagerService;->mPendingBroadcasts:Lcom/android/server/pm/PackageManagerService$PendingPackageBroadcasts;

    invoke-virtual {v4}, Lcom/android/server/pm/PackageManagerService$PendingPackageBroadcasts;->userIdCount()I

    move-result v4

    move/from16 v0, v42

    if-ge v0, v4, :cond_10

    .line 1014
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    iget-object v4, v4, Lcom/android/server/pm/PackageManagerService;->mPendingBroadcasts:Lcom/android/server/pm/PackageManagerService$PendingPackageBroadcasts;

    move/from16 v0, v42

    invoke-virtual {v4, v0}, Lcom/android/server/pm/PackageManagerService$PendingPackageBroadcasts;->userIdAt(I)I

    move-result v47

    .line 1015
    .local v47, "packageUserId":I
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    iget-object v4, v4, Lcom/android/server/pm/PackageManagerService;->mPendingBroadcasts:Lcom/android/server/pm/PackageManagerService$PendingPackageBroadcasts;

    move/from16 v0, v47

    invoke-virtual {v4, v0}, Lcom/android/server/pm/PackageManagerService$PendingPackageBroadcasts;->packagesForUserId(I)Landroid/util/ArrayMap;

    move-result-object v4

    invoke-virtual {v4}, Landroid/util/ArrayMap;->entrySet()Ljava/util/Set;

    move-result-object v4

    invoke-interface {v4}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v39

    .line 1018
    .local v39, "it":Ljava/util/Iterator;, "Ljava/util/Iterator<Ljava/util/Map$Entry<Ljava/lang/String;Ljava/util/ArrayList<Ljava/lang/String;>;>;>;"
    :goto_4
    invoke-interface/range {v39 .. v39}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_f

    move/from16 v0, v35

    move/from16 v1, v56

    if-ge v0, v1, :cond_f

    .line 1019
    invoke-interface/range {v39 .. v39}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v34

    check-cast v34, Ljava/util/Map$Entry;

    .line 1020
    .local v34, "ent":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/util/ArrayList<Ljava/lang/String;>;>;"
    invoke-interface/range {v34 .. v34}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    aput-object v4, v48, v35

    .line 1021
    invoke-interface/range {v34 .. v34}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/util/ArrayList;

    aput-object v4, v29, v35

    .line 1022
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    iget-object v4, v4, Lcom/android/server/pm/PackageManagerService;->mSettings:Lcom/android/server/pm/Settings;

    iget-object v4, v4, Lcom/android/server/pm/Settings;->mPackages:Landroid/util/ArrayMap;

    invoke-interface/range {v34 .. v34}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v6

    invoke-virtual {v4, v6}, Landroid/util/ArrayMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v51

    check-cast v51, Lcom/android/server/pm/PackageSetting;

    .line 1023
    .local v51, "ps":Lcom/android/server/pm/PackageSetting;
    if-eqz v51, :cond_e

    move-object/from16 v0, v51

    iget v4, v0, Lcom/android/server/pm/PackageSetting;->appId:I

    move/from16 v0, v47

    invoke-static {v0, v4}, Landroid/os/UserHandle;->getUid(II)I

    move-result v4

    :goto_5
    aput v4, v59, v35

    .line 1026
    add-int/lit8 v35, v35, 0x1

    .line 1027
    goto :goto_4

    .line 1023
    :cond_e
    const/4 v4, -0x1

    goto :goto_5

    .line 1013
    .end local v34    # "ent":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/util/ArrayList<Ljava/lang/String;>;>;"
    .end local v51    # "ps":Lcom/android/server/pm/PackageSetting;
    :cond_f
    add-int/lit8 v42, v42, 0x1

    goto :goto_3

    .line 1029
    .end local v39    # "it":Ljava/util/Iterator;, "Ljava/util/Iterator<Ljava/util/Map$Entry<Ljava/lang/String;Ljava/util/ArrayList<Ljava/lang/String;>;>;>;"
    .end local v47    # "packageUserId":I
    :cond_10
    move/from16 v56, v35

    .line 1030
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    iget-object v4, v4, Lcom/android/server/pm/PackageManagerService;->mPendingBroadcasts:Lcom/android/server/pm/PackageManagerService$PendingPackageBroadcasts;

    invoke-virtual {v4}, Lcom/android/server/pm/PackageManagerService$PendingPackageBroadcasts;->clear()V

    .line 1031
    monitor-exit v5
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1033
    const/16 v35, 0x0

    :goto_6
    move/from16 v0, v35

    move/from16 v1, v56

    if-ge v0, v1, :cond_11

    .line 1034
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    aget-object v5, v48, v35

    const/4 v6, 0x1

    aget-object v8, v29, v35

    aget v9, v59, v35

    # invokes: Lcom/android/server/pm/PackageManagerService;->sendPackageChangedBroadcast(Ljava/lang/String;ZLjava/util/ArrayList;I)V
    invoke-static {v4, v5, v6, v8, v9}, Lcom/android/server/pm/PackageManagerService;->access$700(Lcom/android/server/pm/PackageManagerService;Ljava/lang/String;ZLjava/util/ArrayList;I)V

    .line 1033
    add-int/lit8 v35, v35, 0x1

    goto :goto_6

    .line 1036
    :cond_11
    const/16 v4, 0xa

    invoke-static {v4}, Landroid/os/Process;->setThreadPriority(I)V

    goto/16 :goto_0

    .line 1040
    .end local v29    # "components":[Ljava/util/ArrayList;, "[Ljava/util/ArrayList<Ljava/lang/String;>;"
    .end local v35    # "i":I
    .end local v42    # "n":I
    .end local v48    # "packages":[Ljava/lang/String;
    .end local v56    # "size":I
    .end local v59    # "uids":[I
    :pswitch_7
    const/4 v4, 0x0

    invoke-static {v4}, Landroid/os/Process;->setThreadPriority(I)V

    .line 1041
    move-object/from16 v0, p1

    iget-object v0, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    move-object/from16 v46, v0

    check-cast v46, Ljava/lang/String;

    .line 1042
    .local v46, "packageName":Ljava/lang/String;
    move-object/from16 v0, p1

    iget v0, v0, Landroid/os/Message;->arg1:I

    move/from16 v62, v0

    .line 1043
    .local v62, "userId":I
    move-object/from16 v0, p1

    iget v4, v0, Landroid/os/Message;->arg2:I

    if-eqz v4, :cond_12

    const/16 v25, 0x1

    .line 1044
    .local v25, "andCode":Z
    :goto_7
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    iget-object v5, v4, Lcom/android/server/pm/PackageManagerService;->mPackages:Landroid/util/ArrayMap;

    monitor-enter v5

    .line 1045
    const/4 v4, -0x1

    move/from16 v0, v62

    if-ne v0, v4, :cond_13

    .line 1046
    :try_start_2
    sget-object v4, Lcom/android/server/pm/PackageManagerService;->sUserManager:Lcom/android/server/pm/UserManagerService;

    invoke-virtual {v4}, Lcom/android/server/pm/UserManagerService;->getUserIds()[I

    move-result-object v63

    .line 1047
    .local v63, "users":[I
    move-object/from16 v28, v63

    .local v28, "arr$":[I
    move-object/from16 v0, v28

    array-length v0, v0

    move/from16 v41, v0

    .local v41, "len$":I
    const/16 v36, 0x0

    .local v36, "i$":I
    :goto_8
    move/from16 v0, v36

    move/from16 v1, v41

    if-ge v0, v1, :cond_14

    aget v61, v28, v36

    .line 1048
    .local v61, "user":I
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    iget-object v4, v4, Lcom/android/server/pm/PackageManagerService;->mSettings:Lcom/android/server/pm/Settings;

    new-instance v6, Landroid/content/pm/PackageCleanItem;

    move/from16 v0, v61

    move-object/from16 v1, v46

    move/from16 v2, v25

    invoke-direct {v6, v0, v1, v2}, Landroid/content/pm/PackageCleanItem;-><init>(ILjava/lang/String;Z)V

    invoke-virtual {v4, v6}, Lcom/android/server/pm/Settings;->addPackageToCleanLPw(Landroid/content/pm/PackageCleanItem;)V

    .line 1047
    add-int/lit8 v36, v36, 0x1

    goto :goto_8

    .line 1043
    .end local v25    # "andCode":Z
    .end local v28    # "arr$":[I
    .end local v36    # "i$":I
    .end local v41    # "len$":I
    .end local v61    # "user":I
    .end local v63    # "users":[I
    :cond_12
    const/16 v25, 0x0

    goto :goto_7

    .line 1052
    .restart local v25    # "andCode":Z
    :cond_13
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    iget-object v4, v4, Lcom/android/server/pm/PackageManagerService;->mSettings:Lcom/android/server/pm/Settings;

    new-instance v6, Landroid/content/pm/PackageCleanItem;

    move/from16 v0, v62

    move-object/from16 v1, v46

    move/from16 v2, v25

    invoke-direct {v6, v0, v1, v2}, Landroid/content/pm/PackageCleanItem;-><init>(ILjava/lang/String;Z)V

    invoke-virtual {v4, v6}, Lcom/android/server/pm/Settings;->addPackageToCleanLPw(Landroid/content/pm/PackageCleanItem;)V

    .line 1055
    :cond_14
    monitor-exit v5
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1056
    const/16 v4, 0xa

    invoke-static {v4}, Landroid/os/Process;->setThreadPriority(I)V

    .line 1057
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    invoke-virtual {v4}, Lcom/android/server/pm/PackageManagerService;->startCleaningPackages()V

    goto/16 :goto_0

    .line 1055
    :catchall_1
    move-exception v4

    :try_start_3
    monitor-exit v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    throw v4

    .line 1061
    .end local v25    # "andCode":Z
    .end local v46    # "packageName":Ljava/lang/String;
    .end local v62    # "userId":I
    :pswitch_8
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    iget-object v4, v4, Lcom/android/server/pm/PackageManagerService;->mRunningInstalls:Landroid/util/SparseArray;

    move-object/from16 v0, p1

    iget v5, v0, Landroid/os/Message;->arg1:I

    invoke-virtual {v4, v5}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v30

    check-cast v30, Lcom/android/server/pm/PackageManagerService$PostInstallData;

    .line 1062
    .local v30, "data":Lcom/android/server/pm/PackageManagerService$PostInstallData;
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    iget-object v4, v4, Lcom/android/server/pm/PackageManagerService;->mRunningInstalls:Landroid/util/SparseArray;

    move-object/from16 v0, p1

    iget v5, v0, Landroid/os/Message;->arg1:I

    invoke-virtual {v4, v5}, Landroid/util/SparseArray;->delete(I)V

    .line 1063
    const/16 v31, 0x0

    .line 1065
    .local v31, "deleteOld":Z
    if-eqz v30, :cond_27

    .line 1066
    move-object/from16 v0, v30

    iget-object v0, v0, Lcom/android/server/pm/PackageManagerService$PostInstallData;->args:Lcom/android/server/pm/PackageManagerService$InstallArgs;

    move-object/from16 v26, v0

    .line 1067
    .local v26, "args":Lcom/android/server/pm/PackageManagerService$InstallArgs;
    move-object/from16 v0, v30

    iget-object v0, v0, Lcom/android/server/pm/PackageManagerService$PostInstallData;->res:Lcom/android/server/pm/PackageManagerService$PackageInstalledInfo;

    move-object/from16 v53, v0

    .line 1069
    .local v53, "res":Lcom/android/server/pm/PackageManagerService$PackageInstalledInfo;
    move-object/from16 v0, v53

    iget v4, v0, Lcom/android/server/pm/PackageManagerService$PackageInstalledInfo;->returnCode:I

    const/4 v5, 0x1

    if-ne v4, v5, :cond_1f

    .line 1070
    move-object/from16 v0, v53

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageInstalledInfo;->removedInfo:Lcom/android/server/pm/PackageManagerService$PackageRemovedInfo;

    const/4 v5, 0x0

    const/4 v6, 0x1

    const/4 v8, 0x0

    invoke-virtual {v4, v5, v6, v8}, Lcom/android/server/pm/PackageManagerService$PackageRemovedInfo;->sendBroadcast(ZZZ)V

    .line 1071
    new-instance v7, Landroid/os/Bundle;

    const/4 v4, 0x1

    invoke-direct {v7, v4}, Landroid/os/Bundle;-><init>(I)V

    .line 1072
    .local v7, "extras":Landroid/os/Bundle;
    const-string v4, "android.intent.extra.UID"

    move-object/from16 v0, v53

    iget v5, v0, Lcom/android/server/pm/PackageManagerService$PackageInstalledInfo;->uid:I

    invoke-virtual {v7, v4, v5}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 1077
    const/4 v4, 0x0

    new-array v0, v4, [I

    move-object/from16 v17, v0

    .line 1078
    .local v17, "updateUsers":[I
    move-object/from16 v0, v53

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageInstalledInfo;->origUsers:[I

    if-eqz v4, :cond_15

    move-object/from16 v0, v53

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageInstalledInfo;->origUsers:[I

    array-length v4, v4

    if-nez v4, :cond_21

    .line 1079
    :cond_15
    move-object/from16 v0, v53

    iget-object v10, v0, Lcom/android/server/pm/PackageManagerService$PackageInstalledInfo;->newUsers:[I

    .line 1106
    .local v10, "firstUsers":[I
    :cond_16
    const-string v4, "android.intent.action.PACKAGE_ADDED"

    move-object/from16 v0, v53

    iget-object v5, v0, Lcom/android/server/pm/PackageManagerService$PackageInstalledInfo;->pkg:Landroid/content/pm/PackageParser$Package;

    iget-object v5, v5, Landroid/content/pm/PackageParser$Package;->applicationInfo:Landroid/content/pm/ApplicationInfo;

    iget-object v5, v5, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    const/4 v6, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    invoke-static/range {v4 .. v10}, Lcom/android/server/pm/PackageManagerService;->sendPackageBroadcast(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/os/Bundle;Ljava/lang/String;Landroid/content/IIntentReceiver;[I)V

    .line 1109
    move-object/from16 v0, v53

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageInstalledInfo;->removedInfo:Lcom/android/server/pm/PackageManagerService$PackageRemovedInfo;

    iget-object v4, v4, Lcom/android/server/pm/PackageManagerService$PackageRemovedInfo;->removedPackage:Ljava/lang/String;

    if-eqz v4, :cond_25

    const/16 v60, 0x1

    .line 1110
    .local v60, "update":Z
    :goto_9
    if-eqz v60, :cond_17

    .line 1111
    const-string v4, "android.intent.extra.REPLACING"

    const/4 v5, 0x1

    invoke-virtual {v7, v4, v5}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 1113
    :cond_17
    const/4 v13, 0x0

    .line 1114
    .local v13, "category":Ljava/lang/String;
    move-object/from16 v0, v53

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageInstalledInfo;->pkg:Landroid/content/pm/PackageParser$Package;

    iget-boolean v4, v4, Landroid/content/pm/PackageParser$Package;->mIsThemeApk:Z

    if-eqz v4, :cond_18

    .line 1115
    const-string v13, "com.tmobile.intent.category.THEME_PACKAGE_INSTALL_STATE_CHANGE"

    .line 1117
    :cond_18
    const-string v11, "android.intent.action.PACKAGE_ADDED"

    move-object/from16 v0, v53

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageInstalledInfo;->pkg:Landroid/content/pm/PackageParser$Package;

    iget-object v4, v4, Landroid/content/pm/PackageParser$Package;->applicationInfo:Landroid/content/pm/ApplicationInfo;

    iget-object v12, v4, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    const/4 v15, 0x0

    const/16 v16, 0x0

    move-object v14, v7

    invoke-static/range {v11 .. v17}, Lcom/android/server/pm/PackageManagerService;->sendPackageBroadcast(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/os/Bundle;Ljava/lang/String;Landroid/content/IIntentReceiver;[I)V

    .line 1120
    if-eqz v60, :cond_1a

    .line 1121
    const-string v11, "android.intent.action.PACKAGE_REPLACED"

    move-object/from16 v0, v53

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageInstalledInfo;->pkg:Landroid/content/pm/PackageParser$Package;

    iget-object v4, v4, Landroid/content/pm/PackageParser$Package;->applicationInfo:Landroid/content/pm/ApplicationInfo;

    iget-object v12, v4, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    const/4 v15, 0x0

    const/16 v16, 0x0

    move-object v14, v7

    invoke-static/range {v11 .. v17}, Lcom/android/server/pm/PackageManagerService;->sendPackageBroadcast(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/os/Bundle;Ljava/lang/String;Landroid/content/IIntentReceiver;[I)V

    .line 1124
    const-string v18, "android.intent.action.MY_PACKAGE_REPLACED"

    const/16 v19, 0x0

    const/16 v20, 0x0

    const/16 v21, 0x0

    move-object/from16 v0, v53

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageInstalledInfo;->pkg:Landroid/content/pm/PackageParser$Package;

    iget-object v4, v4, Landroid/content/pm/PackageParser$Package;->applicationInfo:Landroid/content/pm/ApplicationInfo;

    iget-object v0, v4, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    move-object/from16 v22, v0

    const/16 v23, 0x0

    move-object/from16 v24, v17

    invoke-static/range {v18 .. v24}, Lcom/android/server/pm/PackageManagerService;->sendPackageBroadcast(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/os/Bundle;Ljava/lang/String;Landroid/content/IIntentReceiver;[I)V

    .line 1129
    move-object/from16 v0, v53

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageInstalledInfo;->pkg:Landroid/content/pm/PackageParser$Package;

    # invokes: Lcom/android/server/pm/PackageManagerService;->isForwardLocked(Landroid/content/pm/PackageParser$Package;)Z
    invoke-static {v4}, Lcom/android/server/pm/PackageManagerService;->access$800(Landroid/content/pm/PackageParser$Package;)Z

    move-result v4

    if-nez v4, :cond_19

    move-object/from16 v0, v53

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageInstalledInfo;->pkg:Landroid/content/pm/PackageParser$Package;

    # invokes: Lcom/android/server/pm/PackageManagerService;->isExternal(Landroid/content/pm/PackageParser$Package;)Z
    invoke-static {v4}, Lcom/android/server/pm/PackageManagerService;->access$900(Landroid/content/pm/PackageParser$Package;)Z

    move-result v4

    if-eqz v4, :cond_1a

    .line 1134
    :cond_19
    const/4 v4, 0x1

    new-array v0, v4, [I

    move-object/from16 v22, v0

    const/4 v4, 0x0

    move-object/from16 v0, v53

    iget-object v5, v0, Lcom/android/server/pm/PackageManagerService$PackageInstalledInfo;->pkg:Landroid/content/pm/PackageParser$Package;

    iget-object v5, v5, Landroid/content/pm/PackageParser$Package;->applicationInfo:Landroid/content/pm/ApplicationInfo;

    iget v5, v5, Landroid/content/pm/ApplicationInfo;->uid:I

    aput v5, v22, v4

    .line 1135
    .local v22, "uidArray":[I
    new-instance v21, Ljava/util/ArrayList;

    const/4 v4, 0x1

    move-object/from16 v0, v21

    invoke-direct {v0, v4}, Ljava/util/ArrayList;-><init>(I)V

    .line 1136
    .local v21, "pkgList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    move-object/from16 v0, v53

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageInstalledInfo;->pkg:Landroid/content/pm/PackageParser$Package;

    iget-object v4, v4, Landroid/content/pm/PackageParser$Package;->applicationInfo:Landroid/content/pm/ApplicationInfo;

    iget-object v4, v4, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    move-object/from16 v0, v21

    invoke-virtual {v0, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 1137
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    move-object/from16 v18, v0

    const/16 v19, 0x1

    const/16 v20, 0x1

    const/16 v23, 0x0

    # invokes: Lcom/android/server/pm/PackageManagerService;->sendResourcesChangedBroadcast(ZZLjava/util/ArrayList;[ILandroid/content/IIntentReceiver;)V
    invoke-static/range {v18 .. v23}, Lcom/android/server/pm/PackageManagerService;->access$1000(Lcom/android/server/pm/PackageManagerService;ZZLjava/util/ArrayList;[ILandroid/content/IIntentReceiver;)V

    .line 1142
    .end local v21    # "pkgList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    .end local v22    # "uidArray":[I
    :cond_1a
    move-object/from16 v0, v53

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageInstalledInfo;->pkg:Landroid/content/pm/PackageParser$Package;

    iget-boolean v4, v4, Landroid/content/pm/PackageParser$Package;->mIsThemeApk:Z

    if-nez v4, :cond_1b

    move-object/from16 v0, v53

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageInstalledInfo;->pkg:Landroid/content/pm/PackageParser$Package;

    iget-boolean v4, v4, Landroid/content/pm/PackageParser$Package;->mIsLegacyIconPackApk:Z

    if-eqz v4, :cond_1c

    .line 1143
    :cond_1b
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    move-object/from16 v0, v53

    iget-object v5, v0, Lcom/android/server/pm/PackageManagerService$PackageInstalledInfo;->pkg:Landroid/content/pm/PackageParser$Package;

    iget-object v5, v5, Landroid/content/pm/PackageParser$Package;->packageName:Ljava/lang/String;

    # invokes: Lcom/android/server/pm/PackageManagerService;->processThemeResourcesInThemeService(Ljava/lang/String;)V
    invoke-static {v4, v5}, Lcom/android/server/pm/PackageManagerService;->access$1100(Lcom/android/server/pm/PackageManagerService;Ljava/lang/String;)V

    .line 1145
    :cond_1c
    move-object/from16 v0, v53

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageInstalledInfo;->removedInfo:Lcom/android/server/pm/PackageManagerService$PackageRemovedInfo;

    iget-object v4, v4, Lcom/android/server/pm/PackageManagerService$PackageRemovedInfo;->args:Lcom/android/server/pm/PackageManagerService$InstallArgs;

    if-eqz v4, :cond_1d

    .line 1147
    const/16 v31, 0x1

    .line 1150
    :cond_1d
    if-nez v60, :cond_1e

    move-object/from16 v0, v53

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageInstalledInfo;->pkg:Landroid/content/pm/PackageParser$Package;

    iget-object v4, v4, Landroid/content/pm/PackageParser$Package;->applicationInfo:Landroid/content/pm/ApplicationInfo;

    # invokes: Lcom/android/server/pm/PackageManagerService;->isSystemApp(Landroid/content/pm/ApplicationInfo;)Z
    invoke-static {v4}, Lcom/android/server/pm/PackageManagerService;->access$1200(Landroid/content/pm/ApplicationInfo;)Z

    move-result v4

    if-nez v4, :cond_1e

    .line 1151
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    iget-object v4, v4, Lcom/android/server/pm/PackageManagerService;->mContext:Landroid/content/Context;

    invoke-virtual {v4}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v4

    const-string v5, "privacy_guard_default"

    const/4 v6, 0x0

    const/4 v8, -0x2

    invoke-static {v4, v5, v6, v8}, Landroid/provider/Settings$Secure;->getIntForUser(Landroid/content/ContentResolver;Ljava/lang/String;II)I

    move-result v4

    const/4 v5, 0x1

    if-ne v4, v5, :cond_26

    const/16 v50, 0x1

    .line 1155
    .local v50, "privacyGuard":Z
    :goto_a
    if-eqz v50, :cond_1e

    .line 1156
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    # getter for: Lcom/android/server/pm/PackageManagerService;->mAppOps:Landroid/app/AppOpsManager;
    invoke-static {v4}, Lcom/android/server/pm/PackageManagerService;->access$1300(Lcom/android/server/pm/PackageManagerService;)Landroid/app/AppOpsManager;

    move-result-object v4

    move-object/from16 v0, v53

    iget-object v5, v0, Lcom/android/server/pm/PackageManagerService$PackageInstalledInfo;->pkg:Landroid/content/pm/PackageParser$Package;

    iget-object v5, v5, Landroid/content/pm/PackageParser$Package;->applicationInfo:Landroid/content/pm/ApplicationInfo;

    iget v5, v5, Landroid/content/pm/ApplicationInfo;->uid:I

    move-object/from16 v0, v53

    iget-object v6, v0, Lcom/android/server/pm/PackageManagerService$PackageInstalledInfo;->pkg:Landroid/content/pm/PackageParser$Package;

    iget-object v6, v6, Landroid/content/pm/PackageParser$Package;->applicationInfo:Landroid/content/pm/ApplicationInfo;

    iget-object v6, v6, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    const/4 v8, 0x1

    invoke-virtual {v4, v5, v6, v8}, Landroid/app/AppOpsManager;->setPrivacyGuardSettingForPackage(ILjava/lang/String;Z)V

    .line 1163
    .end local v50    # "privacyGuard":Z
    :cond_1e
    const/16 v4, 0xc26

    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    # invokes: Lcom/android/server/pm/PackageManagerService;->getUnknownSourcesSettings()I
    invoke-static {v5}, Lcom/android/server/pm/PackageManagerService;->access$1400(Lcom/android/server/pm/PackageManagerService;)I

    move-result v5

    invoke-static {v4, v5}, Landroid/util/EventLog;->writeEvent(II)I

    .line 1167
    .end local v7    # "extras":Landroid/os/Bundle;
    .end local v10    # "firstUsers":[I
    .end local v13    # "category":Ljava/lang/String;
    .end local v17    # "updateUsers":[I
    .end local v60    # "update":Z
    :cond_1f
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Runtime;->gc()V

    .line 1169
    if-eqz v31, :cond_20

    .line 1170
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    iget-object v5, v4, Lcom/android/server/pm/PackageManagerService;->mInstallLock:Ljava/lang/Object;

    monitor-enter v5

    .line 1171
    :try_start_4
    move-object/from16 v0, v53

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageInstalledInfo;->removedInfo:Lcom/android/server/pm/PackageManagerService$PackageRemovedInfo;

    iget-object v4, v4, Lcom/android/server/pm/PackageManagerService$PackageRemovedInfo;->args:Lcom/android/server/pm/PackageManagerService$InstallArgs;

    const/4 v6, 0x1

    invoke-virtual {v4, v6}, Lcom/android/server/pm/PackageManagerService$InstallArgs;->doPostDeleteLI(Z)Z

    .line 1172
    monitor-exit v5
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    .line 1174
    :cond_20
    move-object/from16 v0, v26

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$InstallArgs;->observer:Landroid/content/pm/IPackageInstallObserver2;

    if-eqz v4, :cond_0

    .line 1176
    :try_start_5
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    move-object/from16 v0, v53

    invoke-virtual {v4, v0}, Lcom/android/server/pm/PackageManagerService;->extrasForInstallResult(Lcom/android/server/pm/PackageManagerService$PackageInstalledInfo;)Landroid/os/Bundle;

    move-result-object v7

    .line 1177
    .restart local v7    # "extras":Landroid/os/Bundle;
    move-object/from16 v0, v26

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$InstallArgs;->observer:Landroid/content/pm/IPackageInstallObserver2;

    move-object/from16 v0, v53

    iget-object v5, v0, Lcom/android/server/pm/PackageManagerService$PackageInstalledInfo;->name:Ljava/lang/String;

    move-object/from16 v0, v53

    iget v6, v0, Lcom/android/server/pm/PackageManagerService$PackageInstalledInfo;->returnCode:I

    move-object/from16 v0, v53

    iget-object v8, v0, Lcom/android/server/pm/PackageManagerService$PackageInstalledInfo;->returnMsg:Ljava/lang/String;

    invoke-interface {v4, v5, v6, v8, v7}, Landroid/content/pm/IPackageInstallObserver2;->onPackageInstalled(Ljava/lang/String;ILjava/lang/String;Landroid/os/Bundle;)V
    :try_end_5
    .catch Landroid/os/RemoteException; {:try_start_5 .. :try_end_5} :catch_0

    goto/16 :goto_0

    .line 1179
    .end local v7    # "extras":Landroid/os/Bundle;
    :catch_0
    move-exception v33

    .line 1180
    .local v33, "e":Landroid/os/RemoteException;
    const-string v4, "PackageManager"

    const-string v5, "Observer no longer exists."

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 1081
    .end local v33    # "e":Landroid/os/RemoteException;
    .restart local v7    # "extras":Landroid/os/Bundle;
    .restart local v17    # "updateUsers":[I
    :cond_21
    const/4 v4, 0x0

    new-array v10, v4, [I

    .line 1082
    .restart local v10    # "firstUsers":[I
    const/16 v35, 0x0

    .restart local v35    # "i":I
    :goto_b
    move-object/from16 v0, v53

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageInstalledInfo;->newUsers:[I

    array-length v4, v4

    move/from16 v0, v35

    if-ge v0, v4, :cond_16

    .line 1083
    move-object/from16 v0, v53

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageInstalledInfo;->newUsers:[I

    aget v61, v4, v35

    .line 1084
    .restart local v61    # "user":I
    const/16 v38, 0x1

    .line 1085
    .local v38, "isNew":Z
    const/16 v40, 0x0

    .local v40, "j":I
    :goto_c
    move-object/from16 v0, v53

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageInstalledInfo;->origUsers:[I

    array-length v4, v4

    move/from16 v0, v40

    if-ge v0, v4, :cond_22

    .line 1086
    move-object/from16 v0, v53

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageInstalledInfo;->origUsers:[I

    aget v4, v4, v40

    move/from16 v0, v61

    if-ne v4, v0, :cond_23

    .line 1087
    const/16 v38, 0x0

    .line 1091
    :cond_22
    if-eqz v38, :cond_24

    .line 1092
    array-length v4, v10

    add-int/lit8 v4, v4, 0x1

    new-array v0, v4, [I

    move-object/from16 v43, v0

    .line 1093
    .local v43, "newFirst":[I
    const/4 v4, 0x0

    const/4 v5, 0x0

    array-length v6, v10

    move-object/from16 v0, v43

    invoke-static {v10, v4, v0, v5, v6}, Ljava/lang/System;->arraycopy([II[III)V

    .line 1095
    array-length v4, v10

    aput v61, v43, v4

    .line 1096
    move-object/from16 v10, v43

    .line 1082
    .end local v43    # "newFirst":[I
    :goto_d
    add-int/lit8 v35, v35, 0x1

    goto :goto_b

    .line 1085
    :cond_23
    add-int/lit8 v40, v40, 0x1

    goto :goto_c

    .line 1098
    :cond_24
    move-object/from16 v0, v17

    array-length v4, v0

    add-int/lit8 v4, v4, 0x1

    new-array v0, v4, [I

    move-object/from16 v44, v0

    .line 1099
    .local v44, "newUpdate":[I
    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object/from16 v0, v17

    array-length v6, v0

    move-object/from16 v0, v17

    move-object/from16 v1, v44

    invoke-static {v0, v4, v1, v5, v6}, Ljava/lang/System;->arraycopy([II[III)V

    .line 1101
    move-object/from16 v0, v17

    array-length v4, v0

    aput v61, v44, v4

    .line 1102
    move-object/from16 v17, v44

    goto :goto_d

    .line 1109
    .end local v35    # "i":I
    .end local v38    # "isNew":Z
    .end local v40    # "j":I
    .end local v44    # "newUpdate":[I
    .end local v61    # "user":I
    :cond_25
    const/16 v60, 0x0

    goto/16 :goto_9

    .line 1151
    .restart local v13    # "category":Ljava/lang/String;
    .restart local v60    # "update":Z
    :cond_26
    const/16 v50, 0x0

    goto/16 :goto_a

    .line 1172
    .end local v7    # "extras":Landroid/os/Bundle;
    .end local v10    # "firstUsers":[I
    .end local v13    # "category":Ljava/lang/String;
    .end local v17    # "updateUsers":[I
    .end local v60    # "update":Z
    :catchall_2
    move-exception v4

    :try_start_6
    monitor-exit v5
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_2

    throw v4

    .line 1184
    .end local v26    # "args":Lcom/android/server/pm/PackageManagerService$InstallArgs;
    .end local v53    # "res":Lcom/android/server/pm/PackageManagerService$PackageInstalledInfo;
    :cond_27
    const-string v4, "PackageManager"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Bogus post-install token "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    move-object/from16 v0, p1

    iget v6, v0, Landroid/os/Message;->arg1:I

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 1189
    .end local v30    # "data":Lcom/android/server/pm/PackageManagerService$PostInstallData;
    .end local v31    # "deleteOld":Z
    :pswitch_9
    move-object/from16 v0, p1

    iget v4, v0, Landroid/os/Message;->arg1:I

    const/4 v5, 0x1

    if-ne v4, v5, :cond_2a

    const/16 v52, 0x1

    .line 1190
    .local v52, "reportStatus":Z
    :goto_e
    move-object/from16 v0, p1

    iget v4, v0, Landroid/os/Message;->arg2:I

    const/4 v5, 0x1

    if-ne v4, v5, :cond_2b

    const/16 v32, 0x1

    .line 1192
    .local v32, "doGc":Z
    :goto_f
    if-eqz v32, :cond_28

    .line 1194
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Runtime;->gc()V

    .line 1196
    :cond_28
    move-object/from16 v0, p1

    iget-object v4, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    if-eqz v4, :cond_29

    .line 1198
    move-object/from16 v0, p1

    iget-object v0, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    move-object/from16 v27, v0

    check-cast v27, Ljava/util/Set;

    .line 1201
    .local v27, "args":Ljava/util/Set;, "Ljava/util/Set<Lcom/android/server/pm/PackageManagerService$AsecInstallArgs;>;"
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    move-object/from16 v0, v27

    # invokes: Lcom/android/server/pm/PackageManagerService;->unloadAllContainers(Ljava/util/Set;)V
    invoke-static {v4, v0}, Lcom/android/server/pm/PackageManagerService;->access$1500(Lcom/android/server/pm/PackageManagerService;Ljava/util/Set;)V

    .line 1203
    .end local v27    # "args":Ljava/util/Set;, "Ljava/util/Set<Lcom/android/server/pm/PackageManagerService$AsecInstallArgs;>;"
    :cond_29
    if-eqz v52, :cond_0

    .line 1206
    :try_start_7
    invoke-static {}, Lcom/android/internal/content/PackageHelper;->getMountService()Landroid/os/storage/IMountService;

    move-result-object v4

    invoke-interface {v4}, Landroid/os/storage/IMountService;->finishMediaUpdate()V
    :try_end_7
    .catch Landroid/os/RemoteException; {:try_start_7 .. :try_end_7} :catch_1

    goto/16 :goto_0

    .line 1207
    :catch_1
    move-exception v33

    .line 1208
    .restart local v33    # "e":Landroid/os/RemoteException;
    const-string v4, "PackageManager"

    const-string v5, "MountService not running?"

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 1189
    .end local v32    # "doGc":Z
    .end local v33    # "e":Landroid/os/RemoteException;
    .end local v52    # "reportStatus":Z
    :cond_2a
    const/16 v52, 0x0

    goto :goto_e

    .line 1190
    .restart local v52    # "reportStatus":Z
    :cond_2b
    const/16 v32, 0x0

    goto :goto_f

    .line 1213
    .end local v52    # "reportStatus":Z
    :pswitch_a
    const/4 v4, 0x0

    invoke-static {v4}, Landroid/os/Process;->setThreadPriority(I)V

    .line 1214
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    iget-object v5, v4, Lcom/android/server/pm/PackageManagerService;->mPackages:Landroid/util/ArrayMap;

    monitor-enter v5

    .line 1215
    const/16 v4, 0xd

    :try_start_8
    move-object/from16 v0, p0

    invoke-virtual {v0, v4}, Lcom/android/server/pm/PackageManagerService$PackageHandler;->removeMessages(I)V

    .line 1216
    const/16 v4, 0xe

    move-object/from16 v0, p0

    invoke-virtual {v0, v4}, Lcom/android/server/pm/PackageManagerService$PackageHandler;->removeMessages(I)V

    .line 1217
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    iget-object v4, v4, Lcom/android/server/pm/PackageManagerService;->mSettings:Lcom/android/server/pm/Settings;

    invoke-virtual {v4}, Lcom/android/server/pm/Settings;->writeLPr()V

    .line 1218
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    # getter for: Lcom/android/server/pm/PackageManagerService;->mDirtyUsers:Landroid/util/ArraySet;
    invoke-static {v4}, Lcom/android/server/pm/PackageManagerService;->access$1600(Lcom/android/server/pm/PackageManagerService;)Landroid/util/ArraySet;

    move-result-object v4

    invoke-virtual {v4}, Landroid/util/ArraySet;->clear()V

    .line 1219
    monitor-exit v5
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_3

    .line 1220
    const/16 v4, 0xa

    invoke-static {v4}, Landroid/os/Process;->setThreadPriority(I)V

    goto/16 :goto_0

    .line 1219
    :catchall_3
    move-exception v4

    :try_start_9
    monitor-exit v5
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_3

    throw v4

    .line 1223
    :pswitch_b
    const/4 v4, 0x0

    invoke-static {v4}, Landroid/os/Process;->setThreadPriority(I)V

    .line 1224
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    iget-object v5, v4, Lcom/android/server/pm/PackageManagerService;->mPackages:Landroid/util/ArrayMap;

    monitor-enter v5

    .line 1225
    const/16 v4, 0xe

    :try_start_a
    move-object/from16 v0, p0

    invoke-virtual {v0, v4}, Lcom/android/server/pm/PackageManagerService$PackageHandler;->removeMessages(I)V

    .line 1226
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    # getter for: Lcom/android/server/pm/PackageManagerService;->mDirtyUsers:Landroid/util/ArraySet;
    invoke-static {v4}, Lcom/android/server/pm/PackageManagerService;->access$1600(Lcom/android/server/pm/PackageManagerService;)Landroid/util/ArraySet;

    move-result-object v4

    invoke-virtual {v4}, Landroid/util/ArraySet;->iterator()Ljava/util/Iterator;

    move-result-object v36

    .local v36, "i$":Ljava/util/Iterator;
    :goto_10
    invoke-interface/range {v36 .. v36}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_2c

    invoke-interface/range {v36 .. v36}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/Integer;

    invoke-virtual {v4}, Ljava/lang/Integer;->intValue()I

    move-result v62

    .line 1227
    .restart local v62    # "userId":I
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    iget-object v4, v4, Lcom/android/server/pm/PackageManagerService;->mSettings:Lcom/android/server/pm/Settings;

    move/from16 v0, v62

    invoke-virtual {v4, v0}, Lcom/android/server/pm/Settings;->writePackageRestrictionsLPr(I)V

    goto :goto_10

    .line 1230
    .end local v36    # "i$":Ljava/util/Iterator;
    .end local v62    # "userId":I
    :catchall_4
    move-exception v4

    monitor-exit v5
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_4

    throw v4

    .line 1229
    .restart local v36    # "i$":Ljava/util/Iterator;
    :cond_2c
    :try_start_b
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    # getter for: Lcom/android/server/pm/PackageManagerService;->mDirtyUsers:Landroid/util/ArraySet;
    invoke-static {v4}, Lcom/android/server/pm/PackageManagerService;->access$1600(Lcom/android/server/pm/PackageManagerService;)Landroid/util/ArraySet;

    move-result-object v4

    invoke-virtual {v4}, Landroid/util/ArraySet;->clear()V

    .line 1230
    monitor-exit v5
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_4

    .line 1231
    const/16 v4, 0xa

    invoke-static {v4}, Landroid/os/Process;->setThreadPriority(I)V

    goto/16 :goto_0

    .line 1234
    .end local v36    # "i$":Ljava/util/Iterator;
    :pswitch_c
    move-object/from16 v0, p1

    iget v0, v0, Landroid/os/Message;->arg1:I

    move/from16 v64, v0

    .line 1235
    .local v64, "verificationId":I
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    iget-object v4, v4, Lcom/android/server/pm/PackageManagerService;->mPendingVerification:Landroid/util/SparseArray;

    move/from16 v0, v64

    invoke-virtual {v4, v0}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v57

    check-cast v57, Lcom/android/server/pm/PackageVerificationState;

    .line 1237
    .local v57, "state":Lcom/android/server/pm/PackageVerificationState;
    if-eqz v57, :cond_0

    invoke-virtual/range {v57 .. v57}, Lcom/android/server/pm/PackageVerificationState;->timeoutExtended()Z

    move-result v4

    if-nez v4, :cond_0

    .line 1238
    invoke-virtual/range {v57 .. v57}, Lcom/android/server/pm/PackageVerificationState;->getInstallArgs()Lcom/android/server/pm/PackageManagerService$InstallArgs;

    move-result-object v26

    .line 1239
    .restart local v26    # "args":Lcom/android/server/pm/PackageManagerService$InstallArgs;
    move-object/from16 v0, v26

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$InstallArgs;->origin:Lcom/android/server/pm/PackageManagerService$OriginInfo;

    iget-object v4, v4, Lcom/android/server/pm/PackageManagerService$OriginInfo;->resolvedFile:Ljava/io/File;

    invoke-static {v4}, Landroid/net/Uri;->fromFile(Ljava/io/File;)Landroid/net/Uri;

    move-result-object v45

    .line 1241
    .local v45, "originUri":Landroid/net/Uri;
    const-string v4, "PackageManager"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Verification timed out for "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    move-object/from16 v0, v45

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1242
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    iget-object v4, v4, Lcom/android/server/pm/PackageManagerService;->mPendingVerification:Landroid/util/SparseArray;

    move/from16 v0, v64

    invoke-virtual {v4, v0}, Landroid/util/SparseArray;->remove(I)V

    .line 1244
    const/16 v55, -0x16

    .line 1246
    .local v55, "ret":I
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    # invokes: Lcom/android/server/pm/PackageManagerService;->getDefaultVerificationResponse()I
    invoke-static {v4}, Lcom/android/server/pm/PackageManagerService;->access$1700(Lcom/android/server/pm/PackageManagerService;)I

    move-result v4

    const/4 v5, 0x1

    if-ne v4, v5, :cond_2d

    .line 1247
    const-string v4, "PackageManager"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Continuing with installation of "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    move-object/from16 v0, v45

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1248
    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result v4

    const/4 v5, 0x2

    move-object/from16 v0, v57

    invoke-virtual {v0, v4, v5}, Lcom/android/server/pm/PackageVerificationState;->setVerifierResponse(II)Z

    .line 1250
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    const/4 v5, 0x1

    invoke-virtual/range {v57 .. v57}, Lcom/android/server/pm/PackageVerificationState;->getInstallArgs()Lcom/android/server/pm/PackageManagerService$InstallArgs;

    move-result-object v6

    invoke-virtual {v6}, Lcom/android/server/pm/PackageManagerService$InstallArgs;->getUser()Landroid/os/UserHandle;

    move-result-object v6

    move/from16 v0, v64

    move-object/from16 v1, v45

    # invokes: Lcom/android/server/pm/PackageManagerService;->broadcastPackageVerified(ILandroid/net/Uri;ILandroid/os/UserHandle;)V
    invoke-static {v4, v0, v1, v5, v6}, Lcom/android/server/pm/PackageManagerService;->access$1800(Lcom/android/server/pm/PackageManagerService;ILandroid/net/Uri;ILandroid/os/UserHandle;)V

    .line 1254
    :try_start_c
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    # getter for: Lcom/android/server/pm/PackageManagerService;->mContainerService:Lcom/android/internal/app/IMediaContainerService;
    invoke-static {v4}, Lcom/android/server/pm/PackageManagerService;->access$600(Lcom/android/server/pm/PackageManagerService;)Lcom/android/internal/app/IMediaContainerService;

    move-result-object v4

    const/4 v5, 0x1

    move-object/from16 v0, v26

    invoke-virtual {v0, v4, v5}, Lcom/android/server/pm/PackageManagerService$InstallArgs;->copyApk(Lcom/android/internal/app/IMediaContainerService;Z)I
    :try_end_c
    .catch Landroid/os/RemoteException; {:try_start_c .. :try_end_c} :catch_2

    move-result v55

    .line 1264
    :goto_11
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    move-object/from16 v0, v26

    move/from16 v1, v55

    # invokes: Lcom/android/server/pm/PackageManagerService;->processPendingInstall(Lcom/android/server/pm/PackageManagerService$InstallArgs;I)V
    invoke-static {v4, v0, v1}, Lcom/android/server/pm/PackageManagerService;->access$1900(Lcom/android/server/pm/PackageManagerService;Lcom/android/server/pm/PackageManagerService$InstallArgs;I)V

    .line 1265
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    iget-object v4, v4, Lcom/android/server/pm/PackageManagerService;->mHandler:Lcom/android/server/pm/PackageManagerService$PackageHandler;

    const/4 v5, 0x6

    invoke-virtual {v4, v5}, Lcom/android/server/pm/PackageManagerService$PackageHandler;->sendEmptyMessage(I)Z

    goto/16 :goto_0

    .line 1255
    :catch_2
    move-exception v33

    .line 1256
    .restart local v33    # "e":Landroid/os/RemoteException;
    const-string v4, "PackageManager"

    const-string v5, "Could not contact the ContainerService"

    invoke-static {v4, v5}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_11

    .line 1259
    .end local v33    # "e":Landroid/os/RemoteException;
    :cond_2d
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    const/4 v5, -0x1

    invoke-virtual/range {v57 .. v57}, Lcom/android/server/pm/PackageVerificationState;->getInstallArgs()Lcom/android/server/pm/PackageManagerService$InstallArgs;

    move-result-object v6

    invoke-virtual {v6}, Lcom/android/server/pm/PackageManagerService$InstallArgs;->getUser()Landroid/os/UserHandle;

    move-result-object v6

    move/from16 v0, v64

    move-object/from16 v1, v45

    # invokes: Lcom/android/server/pm/PackageManagerService;->broadcastPackageVerified(ILandroid/net/Uri;ILandroid/os/UserHandle;)V
    invoke-static {v4, v0, v1, v5, v6}, Lcom/android/server/pm/PackageManagerService;->access$1800(Lcom/android/server/pm/PackageManagerService;ILandroid/net/Uri;ILandroid/os/UserHandle;)V

    goto :goto_11

    .line 1270
    .end local v26    # "args":Lcom/android/server/pm/PackageManagerService$InstallArgs;
    .end local v45    # "originUri":Landroid/net/Uri;
    .end local v55    # "ret":I
    .end local v57    # "state":Lcom/android/server/pm/PackageVerificationState;
    .end local v64    # "verificationId":I
    :pswitch_d
    move-object/from16 v0, p1

    iget v0, v0, Landroid/os/Message;->arg1:I

    move/from16 v64, v0

    .line 1272
    .restart local v64    # "verificationId":I
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    iget-object v4, v4, Lcom/android/server/pm/PackageManagerService;->mPendingVerification:Landroid/util/SparseArray;

    move/from16 v0, v64

    invoke-virtual {v4, v0}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v57

    check-cast v57, Lcom/android/server/pm/PackageVerificationState;

    .line 1273
    .restart local v57    # "state":Lcom/android/server/pm/PackageVerificationState;
    if-nez v57, :cond_2e

    .line 1274
    const-string v4, "PackageManager"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Invalid verification token "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    move/from16 v0, v64

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " received"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 1278
    :cond_2e
    move-object/from16 v0, p1

    iget-object v0, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    move-object/from16 v54, v0

    check-cast v54, Lcom/android/server/pm/PackageVerificationResponse;

    .line 1280
    .local v54, "response":Lcom/android/server/pm/PackageVerificationResponse;
    move-object/from16 v0, v54

    iget v4, v0, Lcom/android/server/pm/PackageVerificationResponse;->callerUid:I

    move-object/from16 v0, v54

    iget v5, v0, Lcom/android/server/pm/PackageVerificationResponse;->code:I

    move-object/from16 v0, v57

    invoke-virtual {v0, v4, v5}, Lcom/android/server/pm/PackageVerificationState;->setVerifierResponse(II)Z

    .line 1282
    invoke-virtual/range {v57 .. v57}, Lcom/android/server/pm/PackageVerificationState;->isVerificationComplete()Z

    move-result v4

    if-eqz v4, :cond_0

    .line 1283
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    iget-object v4, v4, Lcom/android/server/pm/PackageManagerService;->mPendingVerification:Landroid/util/SparseArray;

    move/from16 v0, v64

    invoke-virtual {v4, v0}, Landroid/util/SparseArray;->remove(I)V

    .line 1285
    invoke-virtual/range {v57 .. v57}, Lcom/android/server/pm/PackageVerificationState;->getInstallArgs()Lcom/android/server/pm/PackageManagerService$InstallArgs;

    move-result-object v26

    .line 1286
    .restart local v26    # "args":Lcom/android/server/pm/PackageManagerService$InstallArgs;
    move-object/from16 v0, v26

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$InstallArgs;->origin:Lcom/android/server/pm/PackageManagerService$OriginInfo;

    iget-object v4, v4, Lcom/android/server/pm/PackageManagerService$OriginInfo;->resolvedFile:Ljava/io/File;

    invoke-static {v4}, Landroid/net/Uri;->fromFile(Ljava/io/File;)Landroid/net/Uri;

    move-result-object v45

    .line 1289
    .restart local v45    # "originUri":Landroid/net/Uri;
    invoke-virtual/range {v57 .. v57}, Lcom/android/server/pm/PackageVerificationState;->isInstallAllowed()Z

    move-result v4

    if-eqz v4, :cond_2f

    .line 1290
    const/16 v55, -0x6e

    .line 1291
    .restart local v55    # "ret":I
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    move-object/from16 v0, v54

    iget v5, v0, Lcom/android/server/pm/PackageVerificationResponse;->code:I

    invoke-virtual/range {v57 .. v57}, Lcom/android/server/pm/PackageVerificationState;->getInstallArgs()Lcom/android/server/pm/PackageManagerService$InstallArgs;

    move-result-object v6

    invoke-virtual {v6}, Lcom/android/server/pm/PackageManagerService$InstallArgs;->getUser()Landroid/os/UserHandle;

    move-result-object v6

    move/from16 v0, v64

    move-object/from16 v1, v45

    # invokes: Lcom/android/server/pm/PackageManagerService;->broadcastPackageVerified(ILandroid/net/Uri;ILandroid/os/UserHandle;)V
    invoke-static {v4, v0, v1, v5, v6}, Lcom/android/server/pm/PackageManagerService;->access$1800(Lcom/android/server/pm/PackageManagerService;ILandroid/net/Uri;ILandroid/os/UserHandle;)V

    .line 1294
    :try_start_d
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    # getter for: Lcom/android/server/pm/PackageManagerService;->mContainerService:Lcom/android/internal/app/IMediaContainerService;
    invoke-static {v4}, Lcom/android/server/pm/PackageManagerService;->access$600(Lcom/android/server/pm/PackageManagerService;)Lcom/android/internal/app/IMediaContainerService;

    move-result-object v4

    const/4 v5, 0x1

    move-object/from16 v0, v26

    invoke-virtual {v0, v4, v5}, Lcom/android/server/pm/PackageManagerService$InstallArgs;->copyApk(Lcom/android/internal/app/IMediaContainerService;Z)I
    :try_end_d
    .catch Landroid/os/RemoteException; {:try_start_d .. :try_end_d} :catch_3

    move-result v55

    .line 1302
    :goto_12
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    move-object/from16 v0, v26

    move/from16 v1, v55

    # invokes: Lcom/android/server/pm/PackageManagerService;->processPendingInstall(Lcom/android/server/pm/PackageManagerService$InstallArgs;I)V
    invoke-static {v4, v0, v1}, Lcom/android/server/pm/PackageManagerService;->access$1900(Lcom/android/server/pm/PackageManagerService;Lcom/android/server/pm/PackageManagerService$InstallArgs;I)V

    .line 1304
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/pm/PackageManagerService$PackageHandler;->this$0:Lcom/android/server/pm/PackageManagerService;

    iget-object v4, v4, Lcom/android/server/pm/PackageManagerService;->mHandler:Lcom/android/server/pm/PackageManagerService$PackageHandler;

    const/4 v5, 0x6

    invoke-virtual {v4, v5}, Lcom/android/server/pm/PackageManagerService$PackageHandler;->sendEmptyMessage(I)Z

    goto/16 :goto_0

    .line 1295
    :catch_3
    move-exception v33

    .line 1296
    .restart local v33    # "e":Landroid/os/RemoteException;
    const-string v4, "PackageManager"

    const-string v5, "Could not contact the ContainerService"

    invoke-static {v4, v5}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_12

    .line 1299
    .end local v33    # "e":Landroid/os/RemoteException;
    .end local v55    # "ret":I
    :cond_2f
    const/16 v55, -0x16

    .restart local v55    # "ret":I
    goto :goto_12

    .line 871
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_6
        :pswitch_0
        :pswitch_2
        :pswitch_0
        :pswitch_1
        :pswitch_4
        :pswitch_7
        :pswitch_0
        :pswitch_8
        :pswitch_3
        :pswitch_5
        :pswitch_9
        :pswitch_a
        :pswitch_b
        :pswitch_d
        :pswitch_c
    .end packed-switch
.end method

.method public handleMessage(Landroid/os/Message;)V
    .locals 2
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/16 v1, 0xa

    .line 864
    :try_start_0
    invoke-virtual {p0, p1}, Lcom/android/server/pm/PackageManagerService$PackageHandler;->doHandleMessage(Landroid/os/Message;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 866
    invoke-static {v1}, Landroid/os/Process;->setThreadPriority(I)V

    .line 868
    return-void

    .line 866
    :catchall_0
    move-exception v0

    invoke-static {v1}, Landroid/os/Process;->setThreadPriority(I)V

    throw v0
.end method
