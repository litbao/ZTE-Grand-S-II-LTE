.class public abstract Lcom/android/internal/telephony/ServiceStateTracker;
.super Landroid/os/Handler;
.source "ServiceStateTracker.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/internal/telephony/ServiceStateTracker$CellInfoResult;
    }
.end annotation


# static fields
.field protected static final ACTION_RADIO_OFF:Ljava/lang/String; = "android.intent.action.ACTION_RADIO_OFF"

.field protected static final DBG:Z = true

.field public static final DEFAULT_GPRS_CHECK_PERIOD_MILLIS:I = 0xea60

.field protected static final EVENT_CDMA_PRL_VERSION_CHANGED:I = 0x28

.field protected static final EVENT_CDMA_SUBSCRIPTION_SOURCE_CHANGED:I = 0x27

.field protected static final EVENT_CHANGE_IMS_STATE:I = 0x2d

.field protected static final EVENT_CHECK_REPORT_GPRS:I = 0x16

.field protected static final EVENT_ERI_FILE_LOADED:I = 0x24

.field protected static final EVENT_GET_CELL_INFO_LIST:I = 0x2b

.field protected static final EVENT_GET_LOC_DONE:I = 0xf

.field protected static final EVENT_GET_LOC_DONE_CDMA:I = 0x1f

.field protected static final EVENT_GET_PREFERRED_NETWORK_TYPE:I = 0x13

.field protected static final EVENT_GET_SIGNAL_STRENGTH:I = 0x3

.field protected static final EVENT_GET_SIGNAL_STRENGTH_CDMA:I = 0x1d

.field public static final EVENT_ICC_CHANGED:I = 0x2a

.field protected static final EVENT_IMS_STATE_CHANGED:I = 0x2e

.field protected static final EVENT_IMS_STATE_DONE:I = 0x2f

.field protected static final EVENT_LOCATION_UPDATES_ENABLED:I = 0x12

.field protected static final EVENT_NETWORK_STATE_CHANGED:I = 0x2

.field protected static final EVENT_NETWORK_STATE_CHANGED_CDMA:I = 0x1e

.field protected static final EVENT_NITZ_TIME:I = 0xb

.field protected static final EVENT_NV_LOADED:I = 0x21

.field protected static final EVENT_NV_READY:I = 0x23

.field protected static final EVENT_OTA_PROVISION_STATUS_CHANGE:I = 0x25

.field protected static final EVENT_POLL_SIGNAL_STRENGTH:I = 0xa

.field protected static final EVENT_POLL_SIGNAL_STRENGTH_CDMA:I = 0x1c

.field protected static final EVENT_POLL_STATE_CDMA_SUBSCRIPTION:I = 0x22

.field protected static final EVENT_POLL_STATE_GPRS:I = 0x5

.field protected static final EVENT_POLL_STATE_NETWORK_SELECTION_MODE:I = 0xe

.field protected static final EVENT_POLL_STATE_OPERATOR:I = 0x6

.field protected static final EVENT_POLL_STATE_OPERATOR_CDMA:I = 0x19

.field protected static final EVENT_POLL_STATE_REGISTRATION:I = 0x4

.field protected static final EVENT_POLL_STATE_REGISTRATION_CDMA:I = 0x18

.field protected static final EVENT_RADIO_AVAILABLE:I = 0xd

.field protected static final EVENT_RADIO_ON:I = 0x29

.field protected static final EVENT_RADIO_STATE_CHANGED:I = 0x1

.field protected static final EVENT_REGISTER_NOTIFY_DELAY:I = 0x37

.field protected static final EVENT_RESET_PREFERRED_NETWORK_TYPE:I = 0x15

.field protected static final EVENT_RESTRICTED_STATE_CHANGED:I = 0x17

.field protected static final EVENT_RUIM_READY:I = 0x1a

.field protected static final EVENT_RUIM_RECORDS_LOADED:I = 0x1b

.field protected static final EVENT_SET_PREFERRED_NETWORK_TYPE:I = 0x14

.field protected static final EVENT_SET_RADIO_POWER_OFF:I = 0x26

.field protected static final EVENT_SIGNAL_STRENGTH_UPDATE:I = 0xc

.field protected static final EVENT_SIGNAL_STRENGTH_UPDATE_SMOOTH:I = 0x7d0

.field protected static final EVENT_SIM_READY:I = 0x11

.field protected static final EVENT_SIM_RECORDS_LOADED:I = 0x10

.field protected static final EVENT_UNSOL_CELL_INFO_LIST:I = 0x2c

.field protected static final GMT_COUNTRY_CODES:[Ljava/lang/String;

.field private static final LAST_CELL_INFO_LIST_MAX_AGE_MS:J = 0x7d0L

.field public static final OTASP_NEEDED:I = 0x2

.field public static final OTASP_NOT_NEEDED:I = 0x3

.field public static final OTASP_UNINITIALIZED:I = 0x0

.field public static final OTASP_UNKNOWN:I = 0x1

.field protected static final POLL_PERIOD_MILLIS:I = 0x4e20

.field protected static final PROP_FORCE_ROAMING:Ljava/lang/String; = "telephony.test.forceRoaming"

.field protected static final REGISTRATION_DENIED_AUTH:Ljava/lang/String; = "Authentication Failure"

.field protected static final REGISTRATION_DENIED_GEN:Ljava/lang/String; = "General"

.field static final SMOOTH_TIMER_DW:I = 0xfa0

.field static final SMOOTH_TIMER_UP:I = 0xbb8

.field protected static final TIMEZONE_PROPERTY:Ljava/lang/String; = "persist.sys.timezone"

.field protected static final VDBG:Z


# instance fields
.field private Dwstep:I

.field private State_Smooth:I

.field private Upstep:I

.field private ifinalSmoothType:I

.field protected lastRegCode:I

.field protected mAlarmSwitch:Z

.field protected mAttachedRegistrants:Landroid/os/RegistrantList;

.field private mCdmaDbmNew:I

.field protected final mCellInfo:Landroid/telephony/CellInfo;

.field protected mCi:Lcom/android/internal/telephony/CommandsInterface;

.field private mCurPlmn:Ljava/lang/String;

.field private mCurShowPlmn:Z

.field private mCurShowSpn:Z

.field private mCurSpn:Ljava/lang/String;

.field private mCurSubId:I

.field protected mDataRegStateOrRatChangedRegistrants:Landroid/os/RegistrantList;

.field protected mDataRoamingOffRegistrants:Landroid/os/RegistrantList;

.field protected mDataRoamingOnRegistrants:Landroid/os/RegistrantList;

.field protected mDesiredPowerState:Z

.field protected mDetachedRegistrants:Landroid/os/RegistrantList;

.field protected mDeviceShuttingDown:Z

.field protected mDontPollSignalStrength:Z

.field private mGsmSignalStrengthNew:I

.field protected mIccRecords:Lcom/android/internal/telephony/uicc/IccRecords;

.field private mImsRegistered:Z

.field protected mImsRegistrationOnOff:Z

.field protected mIntentFilter:Landroid/content/IntentFilter;

.field protected mIwlanRatAvailable:Z

.field protected mLastCellInfoList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Landroid/telephony/CellInfo;",
            ">;"
        }
    .end annotation
.end field

.field protected mLastCellInfoListTime:J

.field private mLastSignalStrength:Landroid/telephony/SignalStrength;

.field private mLteRsrpNew:I

.field protected mNetworkAttachedRegistrants:Landroid/os/RegistrantList;

.field protected mNewSS:Landroid/telephony/ServiceState;

.field protected final mOnSubscriptionsChangedListener:Landroid/telephony/SubscriptionManager$OnSubscriptionsChangedListener;

.field protected mPendingRadioPowerOffAfterDataOff:Z

.field protected mPendingRadioPowerOffAfterDataOffTag:I

.field protected mPhoneBase:Lcom/android/internal/telephony/PhoneBase;

.field protected mPollingContext:[I

.field protected mPowerOffDelayNeed:Z

.field protected mPsRestrictDisabledRegistrants:Landroid/os/RegistrantList;

.field protected mPsRestrictEnabledRegistrants:Landroid/os/RegistrantList;

.field protected mRadioOffIntent:Landroid/app/PendingIntent;

.field private mReceiver:Landroid/content/BroadcastReceiver;

.field protected mRegisterDelay:I

.field public mRestrictedState:Lcom/android/internal/telephony/RestrictedState;

.field public mSS:Landroid/telephony/ServiceState;

.field protected mSignalStrength:Landroid/telephony/SignalStrength;

.field protected mSubscriptionManager:Landroid/telephony/SubscriptionManager;

.field private mTdScdmaRscpNew:I

.field protected mUiccApplcation:Lcom/android/internal/telephony/uicc/UiccCardApplication;

.field protected mUiccController:Lcom/android/internal/telephony/uicc/UiccController;

.field protected mVoiceCapable:Z

.field protected mVoiceRoamingOffRegistrants:Landroid/os/RegistrantList;

.field protected mVoiceRoamingOnRegistrants:Landroid/os/RegistrantList;

.field private mWantContinuousLocationUpdates:Z

.field private mWantSingleLocationUpdate:Z


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    .line 221
    const/16 v0, 0x14

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "bf"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, "ci"

    aput-object v2, v0, v1

    const/4 v1, 0x2

    const-string v2, "eh"

    aput-object v2, v0, v1

    const/4 v1, 0x3

    const-string v2, "fo"

    aput-object v2, v0, v1

    const/4 v1, 0x4

    const-string v2, "gb"

    aput-object v2, v0, v1

    const/4 v1, 0x5

    const-string v2, "gh"

    aput-object v2, v0, v1

    const/4 v1, 0x6

    const-string v2, "gm"

    aput-object v2, v0, v1

    const/4 v1, 0x7

    const-string v2, "gn"

    aput-object v2, v0, v1

    const/16 v1, 0x8

    const-string v2, "gw"

    aput-object v2, v0, v1

    const/16 v1, 0x9

    const-string v2, "ie"

    aput-object v2, v0, v1

    const/16 v1, 0xa

    const-string v2, "lr"

    aput-object v2, v0, v1

    const/16 v1, 0xb

    const-string v2, "is"

    aput-object v2, v0, v1

    const/16 v1, 0xc

    const-string v2, "ma"

    aput-object v2, v0, v1

    const/16 v1, 0xd

    const-string v2, "ml"

    aput-object v2, v0, v1

    const/16 v1, 0xe

    const-string v2, "mr"

    aput-object v2, v0, v1

    const/16 v1, 0xf

    const-string v2, "pt"

    aput-object v2, v0, v1

    const/16 v1, 0x10

    const-string v2, "sl"

    aput-object v2, v0, v1

    const/16 v1, 0x11

    const-string v2, "sn"

    aput-object v2, v0, v1

    const/16 v1, 0x12

    const-string v2, "st"

    aput-object v2, v0, v1

    const/16 v1, 0x13

    const-string v2, "tg"

    aput-object v2, v0, v1

    sput-object v0, Lcom/android/internal/telephony/ServiceStateTracker;->GMT_COUNTRY_CODES:[Ljava/lang/String;

    return-void
.end method

.method protected constructor <init>(Lcom/android/internal/telephony/PhoneBase;Lcom/android/internal/telephony/CommandsInterface;Landroid/telephony/CellInfo;)V
    .locals 6
    .param p1, "phoneBase"    # Lcom/android/internal/telephony/PhoneBase;
    .param p2, "ci"    # Lcom/android/internal/telephony/CommandsInterface;
    .param p3, "cellInfo"    # Landroid/telephony/CellInfo;

    .prologue
    const/4 v1, 0x1

    const/4 v5, 0x0

    const/4 v4, 0x0

    .line 315
    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    .line 68
    iput-object v5, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mUiccController:Lcom/android/internal/telephony/uicc/UiccController;

    .line 69
    iput-object v5, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mUiccApplcation:Lcom/android/internal/telephony/uicc/UiccCardApplication;

    .line 70
    iput-object v5, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mIccRecords:Lcom/android/internal/telephony/uicc/IccRecords;

    .line 76
    new-instance v0, Landroid/telephony/ServiceState;

    invoke-direct {v0}, Landroid/telephony/ServiceState;-><init>()V

    iput-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mSS:Landroid/telephony/ServiceState;

    .line 77
    new-instance v0, Landroid/telephony/ServiceState;

    invoke-direct {v0}, Landroid/telephony/ServiceState;-><init>()V

    iput-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mNewSS:Landroid/telephony/ServiceState;

    .line 81
    iput-object v5, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mLastCellInfoList:Ljava/util/List;

    .line 88
    const/4 v0, -0x1

    iput v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mCurSubId:I

    .line 90
    iput-boolean v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mCurShowPlmn:Z

    .line 92
    iput-boolean v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mCurShowSpn:Z

    .line 94
    new-instance v0, Landroid/telephony/SignalStrength;

    invoke-direct {v0}, Landroid/telephony/SignalStrength;-><init>()V

    iput-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mSignalStrength:Landroid/telephony/SignalStrength;

    .line 97
    new-instance v0, Lcom/android/internal/telephony/RestrictedState;

    invoke-direct {v0}, Lcom/android/internal/telephony/RestrictedState;-><init>()V

    iput-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mRestrictedState:Lcom/android/internal/telephony/RestrictedState;

    .line 118
    iput-boolean v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mDontPollSignalStrength:Z

    .line 120
    new-instance v0, Landroid/os/RegistrantList;

    invoke-direct {v0}, Landroid/os/RegistrantList;-><init>()V

    iput-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mVoiceRoamingOnRegistrants:Landroid/os/RegistrantList;

    .line 121
    new-instance v0, Landroid/os/RegistrantList;

    invoke-direct {v0}, Landroid/os/RegistrantList;-><init>()V

    iput-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mVoiceRoamingOffRegistrants:Landroid/os/RegistrantList;

    .line 122
    new-instance v0, Landroid/os/RegistrantList;

    invoke-direct {v0}, Landroid/os/RegistrantList;-><init>()V

    iput-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mDataRoamingOnRegistrants:Landroid/os/RegistrantList;

    .line 123
    new-instance v0, Landroid/os/RegistrantList;

    invoke-direct {v0}, Landroid/os/RegistrantList;-><init>()V

    iput-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mDataRoamingOffRegistrants:Landroid/os/RegistrantList;

    .line 124
    new-instance v0, Landroid/os/RegistrantList;

    invoke-direct {v0}, Landroid/os/RegistrantList;-><init>()V

    iput-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mAttachedRegistrants:Landroid/os/RegistrantList;

    .line 125
    new-instance v0, Landroid/os/RegistrantList;

    invoke-direct {v0}, Landroid/os/RegistrantList;-><init>()V

    iput-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mDetachedRegistrants:Landroid/os/RegistrantList;

    .line 126
    new-instance v0, Landroid/os/RegistrantList;

    invoke-direct {v0}, Landroid/os/RegistrantList;-><init>()V

    iput-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mDataRegStateOrRatChangedRegistrants:Landroid/os/RegistrantList;

    .line 127
    new-instance v0, Landroid/os/RegistrantList;

    invoke-direct {v0}, Landroid/os/RegistrantList;-><init>()V

    iput-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mNetworkAttachedRegistrants:Landroid/os/RegistrantList;

    .line 128
    new-instance v0, Landroid/os/RegistrantList;

    invoke-direct {v0}, Landroid/os/RegistrantList;-><init>()V

    iput-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPsRestrictEnabledRegistrants:Landroid/os/RegistrantList;

    .line 129
    new-instance v0, Landroid/os/RegistrantList;

    invoke-direct {v0}, Landroid/os/RegistrantList;-><init>()V

    iput-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPsRestrictDisabledRegistrants:Landroid/os/RegistrantList;

    .line 132
    iput-boolean v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPendingRadioPowerOffAfterDataOff:Z

    .line 133
    iput v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPendingRadioPowerOffAfterDataOffTag:I

    .line 136
    iput-boolean v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mIwlanRatAvailable:Z

    .line 197
    iput v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mRegisterDelay:I

    .line 198
    iput v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->lastRegCode:I

    .line 205
    iput v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mGsmSignalStrengthNew:I

    .line 206
    iput v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mTdScdmaRscpNew:I

    .line 207
    iput v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mCdmaDbmNew:I

    .line 208
    iput v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mLteRsrpNew:I

    .line 209
    iput v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->State_Smooth:I

    .line 210
    const/4 v0, 0x3

    iput v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->Upstep:I

    .line 211
    iput v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->Dwstep:I

    .line 212
    iput v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->ifinalSmoothType:I

    .line 253
    iput-boolean v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mImsRegistrationOnOff:Z

    .line 254
    iput-boolean v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mAlarmSwitch:Z

    .line 255
    iput-object v5, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mIntentFilter:Landroid/content/IntentFilter;

    .line 256
    iput-object v5, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mRadioOffIntent:Landroid/app/PendingIntent;

    .line 258
    iput-boolean v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPowerOffDelayNeed:Z

    .line 259
    iput-boolean v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mDeviceShuttingDown:Z

    .line 260
    iput-boolean v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mImsRegistered:Z

    .line 263
    new-instance v0, Lcom/android/internal/telephony/ServiceStateTracker$1;

    invoke-direct {v0, p0}, Lcom/android/internal/telephony/ServiceStateTracker$1;-><init>(Lcom/android/internal/telephony/ServiceStateTracker;)V

    iput-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mOnSubscriptionsChangedListener:Landroid/telephony/SubscriptionManager$OnSubscriptionsChangedListener;

    .line 308
    new-instance v0, Lcom/android/internal/telephony/ServiceStateTracker$2;

    invoke-direct {v0, p0}, Lcom/android/internal/telephony/ServiceStateTracker$2;-><init>(Lcom/android/internal/telephony/ServiceStateTracker;)V

    iput-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mReceiver:Landroid/content/BroadcastReceiver;

    .line 358
    iput-object v5, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mLastSignalStrength:Landroid/telephony/SignalStrength;

    .line 316
    iput-object p1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPhoneBase:Lcom/android/internal/telephony/PhoneBase;

    .line 317
    iput-object p3, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mCellInfo:Landroid/telephony/CellInfo;

    .line 318
    iput-object p2, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    .line 319
    iget-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPhoneBase:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v0}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x112005a

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getBoolean(I)Z

    move-result v0

    iput-boolean v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mVoiceCapable:Z

    .line 321
    invoke-static {}, Lcom/android/internal/telephony/uicc/UiccController;->getInstance()Lcom/android/internal/telephony/uicc/UiccController;

    move-result-object v0

    iput-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mUiccController:Lcom/android/internal/telephony/uicc/UiccController;

    .line 322
    iget-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mUiccController:Lcom/android/internal/telephony/uicc/UiccController;

    const/16 v1, 0x2a

    invoke-virtual {v0, p0, v1, v5}, Lcom/android/internal/telephony/uicc/UiccController;->registerForIccChanged(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 323
    iget-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    const/16 v1, 0xc

    invoke-interface {v0, p0, v1, v5}, Lcom/android/internal/telephony/CommandsInterface;->setOnSignalStrengthUpdate(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 324
    iget-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    const/16 v1, 0x2c

    invoke-interface {v0, p0, v1, v5}, Lcom/android/internal/telephony/CommandsInterface;->registerForCellInfoList(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 326
    invoke-virtual {p1}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Landroid/telephony/SubscriptionManager;->from(Landroid/content/Context;)Landroid/telephony/SubscriptionManager;

    move-result-object v0

    iput-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mSubscriptionManager:Landroid/telephony/SubscriptionManager;

    .line 327
    iget-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mSubscriptionManager:Landroid/telephony/SubscriptionManager;

    iget-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mOnSubscriptionsChangedListener:Landroid/telephony/SubscriptionManager$OnSubscriptionsChangedListener;

    invoke-virtual {v0, v1}, Landroid/telephony/SubscriptionManager;->addOnSubscriptionsChangedListener(Landroid/telephony/SubscriptionManager$OnSubscriptionsChangedListener;)V

    .line 330
    iget-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPhoneBase:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v0}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mReceiver:Landroid/content/BroadcastReceiver;

    new-instance v2, Landroid/content/IntentFilter;

    const-string v3, "android.intent.action.LOCALE_CHANGED"

    invoke-direct {v2, v3}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .line 333
    iget-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPhoneBase:Lcom/android/internal/telephony/PhoneBase;

    const-string v1, "gsm.network.type"

    invoke-static {v4}, Landroid/telephony/ServiceState;->rilRadioTechnologyToString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/android/internal/telephony/PhoneBase;->setSystemProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 335
    iget-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    const/16 v1, 0x2e

    invoke-interface {v0, p0, v1, v5}, Lcom/android/internal/telephony/CommandsInterface;->registerForImsNetworkStateChanged(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 336
    return-void
.end method

.method private adaptCarrierNameToLocale(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "name"    # Ljava/lang/String;

    .prologue
    .line 1427
    const v0, 0x107004a

    const v1, 0x107004b

    invoke-static {p1, p2, v0, v1}, Landroid/util/NativeTextHelper;->getLocalString(Landroid/content/Context;Ljava/lang/String;II)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private geCDMASignalStrengthNew(III)I
    .locals 2
    .param p1, "mcdmaDbm"    # I
    .param p2, "mcdmaDbmLocal"    # I
    .param p3, "SubRssi"    # I

    .prologue
    .line 892
    const/4 v0, 0x0

    .line 893
    .local v0, "resultSignalStrength":I
    if-lez p3, :cond_0

    .line 894
    iget v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->Upstep:I

    add-int v0, p2, v1

    .line 895
    const/4 v1, 0x1

    iput v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->ifinalSmoothType:I

    .line 900
    :goto_0
    return v0

    .line 897
    :cond_0
    iget v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->Dwstep:I

    sub-int v0, p2, v1

    .line 898
    const/4 v1, 0x2

    iput v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->ifinalSmoothType:I

    goto :goto_0
.end method

.method private geLTESignalStrengthNew(III)I
    .locals 2
    .param p1, "mLteRsrp"    # I
    .param p2, "mcmLteRsrqLocal"    # I
    .param p3, "SubRssi"    # I

    .prologue
    .line 920
    const/4 v0, 0x0

    .line 921
    .local v0, "resultSignalStrength":I
    if-lez p3, :cond_0

    .line 922
    iget v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->Upstep:I

    add-int v0, p2, v1

    .line 928
    :goto_0
    return v0

    .line 925
    :cond_0
    iget v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->Dwstep:I

    add-int/lit8 v1, v1, 0x1

    sub-int v0, p2, v1

    goto :goto_0
.end method

.method private geTDSignalStrengthNew(III)I
    .locals 2
    .param p1, "mTdScdmaRscp"    # I
    .param p2, "mTdScdmaRscpLocal"    # I
    .param p3, "SubRssi"    # I

    .prologue
    .line 866
    const/4 v0, 0x0

    .line 867
    .local v0, "resultSignalStrength":I
    if-lez p3, :cond_0

    .line 868
    iget v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->Upstep:I

    add-int v0, p2, v1

    .line 869
    const/4 v1, 0x1

    iput v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->ifinalSmoothType:I

    .line 874
    :goto_0
    return v0

    .line 871
    :cond_0
    iget v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->Dwstep:I

    sub-int v0, p2, v1

    .line 872
    const/4 v1, 0x2

    iput v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->ifinalSmoothType:I

    goto :goto_0
.end method

.method private getGsmSignalStrengthNew(III)I
    .locals 2
    .param p1, "mGsmSignalStrength"    # I
    .param p2, "mGsmSignalLocal"    # I
    .param p3, "SubRssi"    # I

    .prologue
    .line 836
    const/4 v0, 0x0

    .line 837
    .local v0, "resultSignalStrength":I
    if-lez p3, :cond_0

    .line 838
    iget v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->Upstep:I

    add-int v0, p2, v1

    .line 839
    const/4 v1, 0x1

    iput v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->ifinalSmoothType:I

    .line 844
    :goto_0
    return v0

    .line 841
    :cond_0
    iget v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->Dwstep:I

    sub-int v0, p2, v1

    .line 842
    const/4 v1, 0x2

    iput v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->ifinalSmoothType:I

    goto :goto_0
.end method

.method private iSCDMATechnology(I)Z
    .locals 1
    .param p1, "VoiceRadioTechnology"    # I

    .prologue
    .line 904
    const/4 v0, 0x0

    .line 905
    .local v0, "ret":Z
    packed-switch p1, :pswitch_data_0

    .line 913
    :pswitch_0
    const/4 v0, 0x0

    .line 916
    :goto_0
    return v0

    .line 910
    :pswitch_1
    const/4 v0, 0x1

    .line 911
    goto :goto_0

    .line 905
    :pswitch_data_0
    .packed-switch 0x6
        :pswitch_1
        :pswitch_1
        :pswitch_1
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method private iSGsmTechnology(I)Z
    .locals 1
    .param p1, "VoiceRadioTechnology"    # I

    .prologue
    .line 849
    const/4 v0, 0x0

    .line 850
    .local v0, "ret":Z
    sparse-switch p1, :sswitch_data_0

    .line 859
    const/4 v0, 0x0

    .line 862
    :goto_0
    return v0

    .line 856
    :sswitch_0
    const/4 v0, 0x1

    .line 857
    goto :goto_0

    .line 850
    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_0
        0x2 -> :sswitch_0
        0x3 -> :sswitch_0
        0x9 -> :sswitch_0
        0x10 -> :sswitch_0
    .end sparse-switch
.end method

.method private iSLTETechnology(I)Z
    .locals 1
    .param p1, "DataRadioTechnology"    # I

    .prologue
    .line 932
    const/4 v0, 0x0

    .line 933
    .local v0, "ret":Z
    packed-switch p1, :pswitch_data_0

    .line 938
    const/4 v0, 0x0

    .line 941
    :goto_0
    return v0

    .line 935
    :pswitch_0
    const/4 v0, 0x1

    .line 936
    goto :goto_0

    .line 933
    :pswitch_data_0
    .packed-switch 0xe
        :pswitch_0
    .end packed-switch
.end method

.method private iSTDTechnology(I)Z
    .locals 1
    .param p1, "VoiceRadioTechnology"    # I

    .prologue
    .line 878
    const/4 v0, 0x0

    .line 879
    .local v0, "ret":Z
    packed-switch p1, :pswitch_data_0

    .line 884
    const/4 v0, 0x0

    .line 887
    :goto_0
    return v0

    .line 881
    :pswitch_0
    const/4 v0, 0x1

    .line 882
    goto :goto_0

    .line 879
    :pswitch_data_0
    .packed-switch 0x11
        :pswitch_0
    .end packed-switch
.end method


# virtual methods
.method protected cancelPollState()V
    .locals 1

    .prologue
    .line 1119
    const/4 v0, 0x1

    new-array v0, v0, [I

    iput-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPollingContext:[I

    .line 1120
    return-void
.end method

.method protected checkCorrectThread()V
    .locals 2

    .prologue
    .line 1268
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v0

    invoke-virtual {p0}, Lcom/android/internal/telephony/ServiceStateTracker;->getLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-virtual {v1}, Landroid/os/Looper;->getThread()Ljava/lang/Thread;

    move-result-object v1

    if-eq v0, v1, :cond_0

    .line 1269
    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "ServiceStateTracker must be used from within one thread"

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1272
    :cond_0
    return-void
.end method

.method public disableLocationUpdates()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 549
    iput-boolean v2, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mWantContinuousLocationUpdates:Z

    .line 550
    iget-boolean v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mWantSingleLocationUpdate:Z

    if-nez v0, :cond_0

    iget-boolean v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mWantContinuousLocationUpdates:Z

    if-nez v0, :cond_0

    .line 551
    iget-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    const/4 v1, 0x0

    invoke-interface {v0, v2, v1}, Lcom/android/internal/telephony/CommandsInterface;->setLocationUpdates(ZLandroid/os/Message;)V

    .line 553
    :cond_0
    return-void
.end method

.method protected disableSingleLocationUpdate()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 542
    iput-boolean v2, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mWantSingleLocationUpdate:Z

    .line 543
    iget-boolean v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mWantSingleLocationUpdate:Z

    if-nez v0, :cond_0

    iget-boolean v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mWantContinuousLocationUpdates:Z

    if-nez v0, :cond_0

    .line 544
    iget-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    const/4 v1, 0x0

    invoke-interface {v0, v2, v1}, Lcom/android/internal/telephony/CommandsInterface;->setLocationUpdates(ZLandroid/os/Message;)V

    .line 546
    :cond_0
    return-void
.end method

.method public dispose()V
    .locals 2

    .prologue
    .line 346
    iget-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p0}, Lcom/android/internal/telephony/CommandsInterface;->unSetOnSignalStrengthUpdate(Landroid/os/Handler;)V

    .line 347
    iget-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mUiccController:Lcom/android/internal/telephony/uicc/UiccController;

    invoke-virtual {v0, p0}, Lcom/android/internal/telephony/uicc/UiccController;->unregisterForIccChanged(Landroid/os/Handler;)V

    .line 348
    iget-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p0}, Lcom/android/internal/telephony/CommandsInterface;->unregisterForCellInfoList(Landroid/os/Handler;)V

    .line 349
    iget-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mSubscriptionManager:Landroid/telephony/SubscriptionManager;

    iget-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mOnSubscriptionsChangedListener:Landroid/telephony/SubscriptionManager$OnSubscriptionsChangedListener;

    invoke-virtual {v0, v1}, Landroid/telephony/SubscriptionManager;->removeOnSubscriptionsChangedListener(Landroid/telephony/SubscriptionManager$OnSubscriptionsChangedListener;)V

    .line 351
    iget-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPhoneBase:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v0}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v0, v1}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    .line 352
    return-void
.end method

.method public dump(Ljava/io/FileDescriptor;Ljava/io/PrintWriter;[Ljava/lang/String;)V
    .locals 2
    .param p1, "fd"    # Ljava/io/FileDescriptor;
    .param p2, "pw"    # Ljava/io/PrintWriter;
    .param p3, "args"    # [Ljava/lang/String;

    .prologue
    .line 1238
    const-string v0, "ServiceStateTracker:"

    invoke-virtual {p2, v0}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 1239
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, " mSS="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 1240
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, " mNewSS="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mNewSS:Landroid/telephony/ServiceState;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 1241
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, " mCellInfo="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mCellInfo:Landroid/telephony/CellInfo;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 1242
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, " mRestrictedState="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mRestrictedState:Lcom/android/internal/telephony/RestrictedState;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 1243
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, " mPollingContext="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPollingContext:[I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 1244
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, " mDesiredPowerState="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-boolean v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mDesiredPowerState:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 1245
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, " mDontPollSignalStrength="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-boolean v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mDontPollSignalStrength:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 1246
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, " mPendingRadioPowerOffAfterDataOff="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-boolean v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPendingRadioPowerOffAfterDataOff:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 1247
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, " mPendingRadioPowerOffAfterDataOffTag="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPendingRadioPowerOffAfterDataOffTag:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 1248
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, " mCurSubId="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mCurSubId:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 1249
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, " mCurSpn="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mCurSpn:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 1250
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, " mCurShowSpn="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-boolean v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mCurShowSpn:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 1251
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, " mCurPlmn="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mCurPlmn:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 1252
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, " mCurShowPlmn="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-boolean v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mCurShowPlmn:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 1253
    invoke-virtual {p2}, Ljava/io/PrintWriter;->flush()V

    .line 1254
    return-void
.end method

.method public enableLocationUpdates()V
    .locals 3

    .prologue
    const/4 v2, 0x1

    .line 536
    iget-boolean v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mWantSingleLocationUpdate:Z

    if-nez v0, :cond_0

    iget-boolean v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mWantContinuousLocationUpdates:Z

    if-eqz v0, :cond_1

    .line 539
    :cond_0
    :goto_0
    return-void

    .line 537
    :cond_1
    iput-boolean v2, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mWantContinuousLocationUpdates:Z

    .line 538
    iget-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    const/16 v1, 0x12

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/ServiceStateTracker;->obtainMessage(I)Landroid/os/Message;

    move-result-object v1

    invoke-interface {v0, v2, v1}, Lcom/android/internal/telephony/CommandsInterface;->setLocationUpdates(ZLandroid/os/Message;)V

    goto :goto_0
.end method

.method public enableSingleLocationUpdate()V
    .locals 3

    .prologue
    const/4 v2, 0x1

    .line 530
    iget-boolean v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mWantSingleLocationUpdate:Z

    if-nez v0, :cond_0

    iget-boolean v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mWantContinuousLocationUpdates:Z

    if-eqz v0, :cond_1

    .line 533
    :cond_0
    :goto_0
    return-void

    .line 531
    :cond_1
    iput-boolean v2, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mWantSingleLocationUpdate:Z

    .line 532
    iget-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    const/16 v1, 0x12

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/ServiceStateTracker;->obtainMessage(I)Landroid/os/Message;

    move-result-object v1

    invoke-interface {v0, v2, v1}, Lcom/android/internal/telephony/CommandsInterface;->setLocationUpdates(ZLandroid/os/Message;)V

    goto :goto_0
.end method

.method public getAllCellInfo()Ljava/util/List;
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Landroid/telephony/CellInfo;",
            ">;"
        }
    .end annotation

    .prologue
    const/4 v4, 0x0

    .line 1187
    new-instance v2, Lcom/android/internal/telephony/ServiceStateTracker$CellInfoResult;

    invoke-direct {v2, p0, v4}, Lcom/android/internal/telephony/ServiceStateTracker$CellInfoResult;-><init>(Lcom/android/internal/telephony/ServiceStateTracker;Lcom/android/internal/telephony/ServiceStateTracker$1;)V

    .line 1189
    .local v2, "result":Lcom/android/internal/telephony/ServiceStateTracker$CellInfoResult;
    iget-object v5, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v5}, Lcom/android/internal/telephony/CommandsInterface;->getRilVersion()I

    move-result v3

    .line 1190
    .local v3, "ver":I
    const/16 v5, 0x8

    if-lt v3, v5, :cond_2

    .line 1191
    invoke-virtual {p0}, Lcom/android/internal/telephony/ServiceStateTracker;->isCallerOnDifferentThread()Z

    move-result v5

    if-eqz v5, :cond_1

    .line 1192
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v6

    iget-wide v8, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mLastCellInfoListTime:J

    sub-long/2addr v6, v8

    const-wide/16 v8, 0x7d0

    cmp-long v5, v6, v8

    if-lez v5, :cond_0

    .line 1194
    const/16 v5, 0x2b

    invoke-virtual {p0, v5, v2}, Lcom/android/internal/telephony/ServiceStateTracker;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v1

    .line 1195
    .local v1, "msg":Landroid/os/Message;
    iget-object v5, v2, Lcom/android/internal/telephony/ServiceStateTracker$CellInfoResult;->lockObj:Ljava/lang/Object;

    monitor-enter v5

    .line 1196
    const/4 v6, 0x0

    :try_start_0
    iput-object v6, v2, Lcom/android/internal/telephony/ServiceStateTracker$CellInfoResult;->list:Ljava/util/List;

    .line 1197
    iget-object v6, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v6, v1}, Lcom/android/internal/telephony/CommandsInterface;->getCellInfoList(Landroid/os/Message;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1199
    :try_start_1
    iget-object v6, v2, Lcom/android/internal/telephony/ServiceStateTracker$CellInfoResult;->lockObj:Ljava/lang/Object;

    const-wide/16 v8, 0x1388

    invoke-virtual {v6, v8, v9}, Ljava/lang/Object;->wait(J)V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1203
    :goto_0
    :try_start_2
    monitor-exit v5
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 1216
    .end local v1    # "msg":Landroid/os/Message;
    :goto_1
    iget-object v5, v2, Lcom/android/internal/telephony/ServiceStateTracker$CellInfoResult;->lockObj:Ljava/lang/Object;

    monitor-enter v5

    .line 1217
    :try_start_3
    iget-object v6, v2, Lcom/android/internal/telephony/ServiceStateTracker$CellInfoResult;->list:Ljava/util/List;

    if-eqz v6, :cond_3

    .line 1218
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "SST.getAllCellInfo(): X size="

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v6, v2, Lcom/android/internal/telephony/ServiceStateTracker$CellInfoResult;->list:Ljava/util/List;

    invoke-interface {v6}, Ljava/util/List;->size()I

    move-result v6

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v6, " list="

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v6, v2, Lcom/android/internal/telephony/ServiceStateTracker$CellInfoResult;->list:Ljava/util/List;

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Lcom/android/internal/telephony/ServiceStateTracker;->log(Ljava/lang/String;)V

    .line 1220
    iget-object v4, v2, Lcom/android/internal/telephony/ServiceStateTracker$CellInfoResult;->list:Ljava/util/List;

    monitor-exit v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1223
    :goto_2
    return-object v4

    .line 1200
    .restart local v1    # "msg":Landroid/os/Message;
    :catch_0
    move-exception v0

    .line 1201
    .local v0, "e":Ljava/lang/InterruptedException;
    :try_start_4
    invoke-virtual {v0}, Ljava/lang/InterruptedException;->printStackTrace()V

    goto :goto_0

    .line 1203
    .end local v0    # "e":Ljava/lang/InterruptedException;
    :catchall_0
    move-exception v4

    monitor-exit v5
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    throw v4

    .line 1205
    .end local v1    # "msg":Landroid/os/Message;
    :cond_0
    const-string v5, "SST.getAllCellInfo(): return last, back to back calls"

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/ServiceStateTracker;->log(Ljava/lang/String;)V

    .line 1206
    iget-object v5, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mLastCellInfoList:Ljava/util/List;

    iput-object v5, v2, Lcom/android/internal/telephony/ServiceStateTracker$CellInfoResult;->list:Ljava/util/List;

    goto :goto_1

    .line 1209
    :cond_1
    const-string v5, "SST.getAllCellInfo(): return last, same thread can\'t block"

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/ServiceStateTracker;->log(Ljava/lang/String;)V

    .line 1210
    iget-object v5, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mLastCellInfoList:Ljava/util/List;

    iput-object v5, v2, Lcom/android/internal/telephony/ServiceStateTracker$CellInfoResult;->list:Ljava/util/List;

    goto :goto_1

    .line 1213
    :cond_2
    const-string v5, "SST.getAllCellInfo(): not implemented"

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/ServiceStateTracker;->log(Ljava/lang/String;)V

    .line 1214
    iput-object v4, v2, Lcom/android/internal/telephony/ServiceStateTracker$CellInfoResult;->list:Ljava/util/List;

    goto :goto_1

    .line 1222
    :cond_3
    :try_start_5
    const-string v6, "SST.getAllCellInfo(): X size=0 list=null"

    invoke-virtual {p0, v6}, Lcom/android/internal/telephony/ServiceStateTracker;->log(Ljava/lang/String;)V

    .line 1223
    monitor-exit v5

    goto :goto_2

    .line 1225
    :catchall_1
    move-exception v4

    monitor-exit v5
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    throw v4
.end method

.method public abstract getCurrentDataConnectionState()I
.end method

.method public getDesiredPowerState()Z
    .locals 1

    .prologue
    .line 355
    iget-boolean v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mDesiredPowerState:Z

    return v0
.end method

.method protected getHomeOperatorNumeric()Ljava/lang/String;
    .locals 3

    .prologue
    .line 1416
    iget-object v2, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPhoneBase:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v2}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v0

    .line 1417
    .local v0, "context":Landroid/content/Context;
    const-string v2, "phone"

    invoke-virtual {v0, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/telephony/TelephonyManager;

    .line 1419
    .local v1, "tm":Landroid/telephony/TelephonyManager;
    iget-object v2, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPhoneBase:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v2}, Lcom/android/internal/telephony/PhoneBase;->getPhoneId()I

    move-result v2

    invoke-virtual {v1, v2}, Landroid/telephony/TelephonyManager;->getSimOperatorNumericForPhone(I)Ljava/lang/String;

    move-result-object v2

    return-object v2
.end method

.method protected abstract getPhone()Lcom/android/internal/telephony/Phone;
.end method

.method protected getPhoneId()I
    .locals 1

    .prologue
    .line 1423
    iget-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPhoneBase:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v0}, Lcom/android/internal/telephony/PhoneBase;->getPhoneId()I

    move-result v0

    return v0
.end method

.method public getSignalStrength()Landroid/telephony/SignalStrength;
    .locals 2

    .prologue
    .line 1232
    iget-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mCellInfo:Landroid/telephony/CellInfo;

    monitor-enter v1

    .line 1233
    :try_start_0
    iget-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mSignalStrength:Landroid/telephony/SignalStrength;

    monitor-exit v1

    return-object v0

    .line 1234
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public getSystemProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p1, "property"    # Ljava/lang/String;
    .param p2, "defValue"    # Ljava/lang/String;

    .prologue
    .line 1180
    iget-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPhoneBase:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v0}, Lcom/android/internal/telephony/PhoneBase;->getPhoneId()I

    move-result v0

    invoke-static {v0, p1, p2}, Landroid/telephony/TelephonyManager;->getTelephonyProperty(ILjava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public handleMessage(Landroid/os/Message;)V
    .locals 8
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/4 v5, 0x1

    const/4 v6, 0x0

    .line 557
    iget v4, p1, Landroid/os/Message;->what:I

    packed-switch v4, :pswitch_data_0

    .line 629
    :pswitch_0
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Unhandled message with number: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget v5, p1, Landroid/os/Message;->what:I

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Lcom/android/internal/telephony/ServiceStateTracker;->log(Ljava/lang/String;)V

    .line 632
    :cond_0
    :goto_0
    return-void

    .line 559
    :pswitch_1
    monitor-enter p0

    .line 560
    :try_start_0
    iget-boolean v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPendingRadioPowerOffAfterDataOff:Z

    if-eqz v4, :cond_1

    iget v4, p1, Landroid/os/Message;->arg1:I

    iget v5, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPendingRadioPowerOffAfterDataOffTag:I

    if-ne v4, v5, :cond_1

    .line 562
    const-string v4, "EVENT_SET_RADIO_OFF, turn radio off now."

    invoke-virtual {p0, v4}, Lcom/android/internal/telephony/ServiceStateTracker;->log(Ljava/lang/String;)V

    .line 563
    invoke-virtual {p0}, Lcom/android/internal/telephony/ServiceStateTracker;->hangupAndPowerOff()V

    .line 564
    iget v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPendingRadioPowerOffAfterDataOffTag:I

    add-int/lit8 v4, v4, 0x1

    iput v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPendingRadioPowerOffAfterDataOffTag:I

    .line 565
    const/4 v4, 0x0

    iput-boolean v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPendingRadioPowerOffAfterDataOff:Z

    .line 570
    :goto_1
    monitor-exit p0

    goto :goto_0

    :catchall_0
    move-exception v4

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v4

    .line 567
    :cond_1
    :try_start_1
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "EVENT_SET_RADIO_OFF is stale arg1="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget v5, p1, Landroid/os/Message;->arg1:I

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "!= tag="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget v5, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPendingRadioPowerOffAfterDataOffTag:I

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Lcom/android/internal/telephony/ServiceStateTracker;->log(Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_1

    .line 574
    :pswitch_2
    invoke-virtual {p0}, Lcom/android/internal/telephony/ServiceStateTracker;->onUpdateIccAvailability()V

    goto :goto_0

    .line 578
    :pswitch_3
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .line 579
    .local v0, "ar":Landroid/os/AsyncResult;
    iget-object v3, v0, Landroid/os/AsyncResult;->userObj:Ljava/lang/Object;

    check-cast v3, Lcom/android/internal/telephony/ServiceStateTracker$CellInfoResult;

    .line 580
    .local v3, "result":Lcom/android/internal/telephony/ServiceStateTracker$CellInfoResult;
    iget-object v5, v3, Lcom/android/internal/telephony/ServiceStateTracker$CellInfoResult;->lockObj:Ljava/lang/Object;

    monitor-enter v5

    .line 581
    :try_start_2
    iget-object v4, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-eqz v4, :cond_2

    .line 582
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "EVENT_GET_CELL_INFO_LIST: error ret null, e="

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v6, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Lcom/android/internal/telephony/ServiceStateTracker;->log(Ljava/lang/String;)V

    .line 583
    const/4 v4, 0x0

    iput-object v4, v3, Lcom/android/internal/telephony/ServiceStateTracker$CellInfoResult;->list:Ljava/util/List;

    .line 592
    :goto_2
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v6

    iput-wide v6, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mLastCellInfoListTime:J

    .line 593
    iget-object v4, v3, Lcom/android/internal/telephony/ServiceStateTracker$CellInfoResult;->list:Ljava/util/List;

    iput-object v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mLastCellInfoList:Ljava/util/List;

    .line 594
    iget-object v4, v3, Lcom/android/internal/telephony/ServiceStateTracker$CellInfoResult;->lockObj:Ljava/lang/Object;

    invoke-virtual {v4}, Ljava/lang/Object;->notify()V

    .line 595
    monitor-exit v5

    goto/16 :goto_0

    :catchall_1
    move-exception v4

    monitor-exit v5
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    throw v4

    .line 585
    :cond_2
    :try_start_3
    iget-object v4, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v4, Ljava/util/List;

    iput-object v4, v3, Lcom/android/internal/telephony/ServiceStateTracker$CellInfoResult;->list:Ljava/util/List;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    goto :goto_2

    .line 600
    .end local v0    # "ar":Landroid/os/AsyncResult;
    .end local v3    # "result":Lcom/android/internal/telephony/ServiceStateTracker$CellInfoResult;
    :pswitch_4
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .line 601
    .restart local v0    # "ar":Landroid/os/AsyncResult;
    iget-object v4, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-eqz v4, :cond_3

    .line 602
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "EVENT_UNSOL_CELL_INFO_LIST: error ignoring, e="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Lcom/android/internal/telephony/ServiceStateTracker;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 604
    :cond_3
    iget-object v1, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v1, Ljava/util/List;

    .line 606
    .local v1, "list":Ljava/util/List;, "Ljava/util/List<Landroid/telephony/CellInfo;>;"
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "EVENT_UNSOL_CELL_INFO_LIST: size="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " list="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Lcom/android/internal/telephony/ServiceStateTracker;->log(Ljava/lang/String;)V

    .line 609
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v4

    iput-wide v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mLastCellInfoListTime:J

    .line 610
    iput-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mLastCellInfoList:Ljava/util/List;

    .line 611
    iget-object v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPhoneBase:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v4, v1}, Lcom/android/internal/telephony/PhoneBase;->notifyCellInfo(Ljava/util/List;)V

    goto/16 :goto_0

    .line 617
    .end local v0    # "ar":Landroid/os/AsyncResult;
    .end local v1    # "list":Ljava/util/List;, "Ljava/util/List<Landroid/telephony/CellInfo;>;"
    :pswitch_5
    iget-object v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    const/16 v5, 0x2f

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/ServiceStateTracker;->obtainMessage(I)Landroid/os/Message;

    move-result-object v5

    invoke-interface {v4, v5}, Lcom/android/internal/telephony/CommandsInterface;->getImsRegistrationState(Landroid/os/Message;)V

    goto/16 :goto_0

    .line 621
    :pswitch_6
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .line 622
    .restart local v0    # "ar":Landroid/os/AsyncResult;
    iget-object v4, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-nez v4, :cond_0

    .line 623
    iget-object v4, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v4, [I

    move-object v2, v4

    check-cast v2, [I

    .line 624
    .local v2, "responseArray":[I
    aget v4, v2, v6

    if-ne v4, v5, :cond_4

    move v4, v5

    :goto_3
    iput-boolean v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mImsRegistered:Z

    goto/16 :goto_0

    :cond_4
    move v4, v6

    goto :goto_3

    .line 557
    :pswitch_data_0
    .packed-switch 0x26
        :pswitch_1
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_2
        :pswitch_3
        :pswitch_4
        :pswitch_0
        :pswitch_5
        :pswitch_6
    .end packed-switch
.end method

.method protected abstract handlePollStateResult(ILandroid/os/AsyncResult;)V
.end method

.method protected abstract hangupAndPowerOff()V
.end method

.method protected inSameCountry(Ljava/lang/String;)Z
    .locals 13
    .param p1, "operatorNumeric"    # Ljava/lang/String;

    .prologue
    const/4 v12, 0x5

    const/4 v11, 0x3

    const/4 v9, 0x0

    .line 1372
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v10

    if-nez v10, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v10

    if-ge v10, v12, :cond_2

    :cond_0
    move v5, v9

    .line 1410
    :cond_1
    :goto_0
    return v5

    .line 1376
    :cond_2
    invoke-virtual {p0}, Lcom/android/internal/telephony/ServiceStateTracker;->getHomeOperatorNumeric()Ljava/lang/String;

    move-result-object v4

    .line 1377
    .local v4, "homeNumeric":Ljava/lang/String;
    invoke-static {v4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v10

    if-nez v10, :cond_3

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v10

    if-ge v10, v12, :cond_4

    :cond_3
    move v5, v9

    .line 1379
    goto :goto_0

    .line 1381
    :cond_4
    const/4 v5, 0x1

    .line 1382
    .local v5, "inSameCountry":Z
    invoke-virtual {p1, v9, v11}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v7

    .line 1383
    .local v7, "networkMCC":Ljava/lang/String;
    invoke-virtual {v4, v9, v11}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    .line 1387
    .local v2, "homeMCC":Ljava/lang/String;
    :try_start_0
    invoke-static {v7}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v8

    .line 1388
    .local v8, "networkMccInt":I
    invoke-static {v2}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v3

    .line 1394
    .local v3, "homeMccInt":I
    invoke-static {v8}, Lcom/android/internal/telephony/MccTable;->countryCodeForMcc(I)Ljava/lang/String;

    move-result-object v6

    .line 1395
    .local v6, "networkCountry":Ljava/lang/String;
    invoke-static {v3}, Lcom/android/internal/telephony/MccTable;->countryCodeForMcc(I)Ljava/lang/String;

    move-result-object v1

    .line 1396
    .local v1, "homeCountry":Ljava/lang/String;
    invoke-virtual {v6}, Ljava/lang/String;->isEmpty()Z

    move-result v10

    if-nez v10, :cond_5

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v10

    if-eqz v10, :cond_6

    :cond_5
    move v5, v9

    .line 1398
    goto :goto_0

    .line 1389
    .end local v1    # "homeCountry":Ljava/lang/String;
    .end local v3    # "homeMccInt":I
    .end local v6    # "networkCountry":Ljava/lang/String;
    .end local v8    # "networkMccInt":I
    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/NumberFormatException;
    move v5, v9

    .line 1391
    goto :goto_0

    .line 1400
    .end local v0    # "e":Ljava/lang/NumberFormatException;
    .restart local v1    # "homeCountry":Ljava/lang/String;
    .restart local v3    # "homeMccInt":I
    .restart local v6    # "networkCountry":Ljava/lang/String;
    .restart local v8    # "networkMccInt":I
    :cond_6
    invoke-virtual {v1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    .line 1401
    if-nez v5, :cond_1

    .line 1405
    const-string v9, "us"

    invoke-virtual {v9, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_7

    const-string v9, "vi"

    invoke-virtual {v9, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_7

    .line 1406
    const/4 v5, 0x1

    goto :goto_0

    .line 1407
    :cond_7
    const-string v9, "vi"

    invoke-virtual {v9, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_1

    const-string v9, "us"

    invoke-virtual {v9, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_1

    .line 1408
    const/4 v5, 0x1

    goto :goto_0
.end method

.method protected isCallerOnDifferentThread()Z
    .locals 3

    .prologue
    .line 1275
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v1

    invoke-virtual {p0}, Lcom/android/internal/telephony/ServiceStateTracker;->getLooper()Landroid/os/Looper;

    move-result-object v2

    invoke-virtual {v2}, Landroid/os/Looper;->getThread()Ljava/lang/Thread;

    move-result-object v2

    if-eq v1, v2, :cond_0

    const/4 v0, 0x1

    .line 1277
    .local v0, "value":Z
    :goto_0
    return v0

    .line 1275
    .end local v0    # "value":Z
    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public abstract isConcurrentVoiceAndDataAllowed()Z
.end method

.method public isImsRegistered()Z
    .locals 1

    .prologue
    .line 1257
    iget-boolean v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mImsRegistered:Z

    return v0
.end method

.method protected isIwlanFeatureAvailable()Z
    .locals 3

    .prologue
    .line 1290
    iget-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPhoneBase:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v1}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const v2, 0x11200ad

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getBoolean(I)Z

    move-result v0

    .line 1292
    .local v0, "iwlanAvailable":Z
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Iwlan feature available = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/ServiceStateTracker;->log(Ljava/lang/String;)V

    .line 1293
    return v0
.end method

.method protected abstract log(Ljava/lang/String;)V
.end method

.method protected abstract loge(Ljava/lang/String;)V
.end method

.method protected notifyDataRegStateRilRadioTechnologyChanged()V
    .locals 6

    .prologue
    .line 381
    iget-object v2, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v2}, Landroid/telephony/ServiceState;->getRilDataRadioTechnology()I

    move-result v1

    .line 382
    .local v1, "rat":I
    iget-object v2, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v2}, Landroid/telephony/ServiceState;->getDataRegState()I

    move-result v0

    .line 383
    .local v0, "drs":I
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "notifyDataRegStateRilRadioTechnologyChanged: drs="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " rat="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/ServiceStateTracker;->log(Ljava/lang/String;)V

    .line 384
    iget-object v2, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPhoneBase:Lcom/android/internal/telephony/PhoneBase;

    const-string v3, "gsm.network.type"

    invoke-static {v1}, Landroid/telephony/ServiceState;->rilRadioTechnologyToString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Lcom/android/internal/telephony/PhoneBase;->setSystemProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 386
    iget-object v2, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mDataRegStateOrRatChangedRegistrants:Landroid/os/RegistrantList;

    new-instance v3, Landroid/util/Pair;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-direct {v3, v4, v5}, Landroid/util/Pair;-><init>(Ljava/lang/Object;Ljava/lang/Object;)V

    invoke-virtual {v2, v3}, Landroid/os/RegistrantList;->notifyResult(Ljava/lang/Object;)V

    .line 387
    return-void
.end method

.method protected notifySignalStrength()Z
    .locals 5

    .prologue
    .line 360
    const/4 v1, 0x0

    .line 361
    .local v1, "notified":Z
    iget-object v3, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mCellInfo:Landroid/telephony/CellInfo;

    monitor-enter v3

    .line 362
    :try_start_0
    iget-object v2, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mSignalStrength:Landroid/telephony/SignalStrength;

    iget-object v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mLastSignalStrength:Landroid/telephony/SignalStrength;

    invoke-virtual {v2, v4}, Landroid/telephony/SignalStrength;->equals(Ljava/lang/Object;)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v2

    if-nez v2, :cond_0

    .line 364
    :try_start_1
    iget-object v2, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPhoneBase:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v2}, Lcom/android/internal/telephony/PhoneBase;->notifySignalStrength()V
    :try_end_1
    .catch Ljava/lang/NullPointerException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 365
    const/4 v1, 0x1

    .line 371
    :cond_0
    :goto_0
    :try_start_2
    monitor-exit v3

    .line 372
    return v1

    .line 366
    :catch_0
    move-exception v0

    .line 367
    .local v0, "ex":Ljava/lang/NullPointerException;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "updateSignalStrength() Phone already destroyed: "

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, "SignalStrength not notified"

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/ServiceStateTracker;->loge(Ljava/lang/String;)V

    goto :goto_0

    .line 371
    .end local v0    # "ex":Ljava/lang/NullPointerException;
    :catchall_0
    move-exception v2

    monitor-exit v3
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v2
.end method

.method protected onSignalStrengthResult(Landroid/os/AsyncResult;Z)Z
    .locals 3
    .param p1, "ar"    # Landroid/os/AsyncResult;
    .param p2, "isGsm"    # Z

    .prologue
    .line 1094
    iget-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mSignalStrength:Landroid/telephony/SignalStrength;

    .line 1099
    .local v0, "oldSignalStrength":Landroid/telephony/SignalStrength;
    iget-object v1, p1, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-nez v1, :cond_0

    iget-object v1, p1, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    if-eqz v1, :cond_0

    .line 1100
    iget-object v1, p1, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v1, Landroid/telephony/SignalStrength;

    iput-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mSignalStrength:Landroid/telephony/SignalStrength;

    .line 1101
    iget-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mSignalStrength:Landroid/telephony/SignalStrength;

    invoke-virtual {v1}, Landroid/telephony/SignalStrength;->validateInput()V

    .line 1102
    iget-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mSignalStrength:Landroid/telephony/SignalStrength;

    invoke-virtual {v1, p2}, Landroid/telephony/SignalStrength;->setGsm(Z)V

    .line 1108
    :goto_0
    invoke-virtual {p0}, Lcom/android/internal/telephony/ServiceStateTracker;->notifySignalStrength()Z

    move-result v1

    return v1

    .line 1104
    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onSignalStrengthResult() Exception from RIL : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p1, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/ServiceStateTracker;->log(Ljava/lang/String;)V

    .line 1105
    new-instance v1, Landroid/telephony/SignalStrength;

    invoke-direct {v1, p2}, Landroid/telephony/SignalStrength;-><init>(Z)V

    iput-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mSignalStrength:Landroid/telephony/SignalStrength;

    goto :goto_0
.end method

.method protected onSignalStrengthResult_Smooth(Landroid/os/AsyncResult;Z)Z
    .locals 34
    .param p1, "ar"    # Landroid/os/AsyncResult;
    .param p2, "isGsm"    # Z

    .prologue
    .line 945
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/ServiceStateTracker;->mSignalStrength:Landroid/telephony/SignalStrength;

    move-object/from16 v28, v0

    .line 946
    .local v28, "oldSignalStrength":Landroid/telephony/SignalStrength;
    const/16 v25, 0x0

    .line 947
    .local v25, "mSignalStrengthTmp":Landroid/telephony/SignalStrength;
    const/16 v27, 0x0

    .line 948
    .local v27, "newlevel":I
    const/16 v29, 0x0

    .line 949
    .local v29, "oldlevel":I
    const/16 v20, 0x0

    .line 950
    .local v20, "Sublevel":I
    const/16 v30, 0x63

    .line 951
    .local v30, "oldrssi":I
    const/16 v19, 0x0

    .line 954
    .local v19, "SubRssi":I
    const/4 v4, 0x0

    move-object/from16 v0, p0

    iput v4, v0, Lcom/android/internal/telephony/ServiceStateTracker;->ifinalSmoothType:I

    .line 955
    const/16 v4, 0x7d0

    move-object/from16 v0, p0

    invoke-virtual {v0, v4}, Lcom/android/internal/telephony/ServiceStateTracker;->removeMessages(I)V

    .line 957
    move-object/from16 v0, p1

    iget-object v4, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-nez v4, :cond_0

    move-object/from16 v0, p1

    iget-object v4, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    if-eqz v4, :cond_0

    .line 958
    move-object/from16 v0, p1

    iget-object v0, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    move-object/from16 v25, v0

    .end local v25    # "mSignalStrengthTmp":Landroid/telephony/SignalStrength;
    check-cast v25, Landroid/telephony/SignalStrength;

    .line 959
    .restart local v25    # "mSignalStrengthTmp":Landroid/telephony/SignalStrength;
    invoke-virtual/range {v25 .. v25}, Landroid/telephony/SignalStrength;->validateInput()V

    .line 960
    move-object/from16 v0, v25

    move/from16 v1, p2

    invoke-virtual {v0, v1}, Landroid/telephony/SignalStrength;->setGsm(Z)V

    .line 966
    :goto_0
    invoke-virtual/range {v25 .. v25}, Landroid/telephony/SignalStrength;->getGsmSignalStrength()I

    move-result v23

    .line 967
    .local v23, "mGsmSignalStrength":I
    invoke-virtual/range {v25 .. v25}, Landroid/telephony/SignalStrength;->getGsmBitErrorRate()I

    move-result v6

    .line 968
    .local v6, "mGsmBitErrorRate":I
    invoke-virtual/range {v25 .. v25}, Landroid/telephony/SignalStrength;->getCdmaDbm()I

    move-result v22

    .line 969
    .local v22, "mCdmaDbm":I
    invoke-virtual/range {v25 .. v25}, Landroid/telephony/SignalStrength;->getCdmaEcio()I

    move-result v8

    .line 970
    .local v8, "mCdmaEcio":I
    invoke-virtual/range {v25 .. v25}, Landroid/telephony/SignalStrength;->getEvdoDbm()I

    move-result v9

    .line 971
    .local v9, "mEvdoDbm":I
    invoke-virtual/range {v25 .. v25}, Landroid/telephony/SignalStrength;->getEvdoEcio()I

    move-result v10

    .line 972
    .local v10, "mEvdoEcio":I
    invoke-virtual/range {v25 .. v25}, Landroid/telephony/SignalStrength;->getEvdoSnr()I

    move-result v11

    .line 973
    .local v11, "mEvdoSnr":I
    invoke-virtual/range {v25 .. v25}, Landroid/telephony/SignalStrength;->getLteSignalStrength()I

    move-result v12

    .line 974
    .local v12, "mLteSignalStrength":I
    invoke-virtual/range {v25 .. v25}, Landroid/telephony/SignalStrength;->getLteRsrp()I

    move-result v24

    .line 975
    .local v24, "mLteRsrp":I
    invoke-virtual/range {v25 .. v25}, Landroid/telephony/SignalStrength;->getLteRsrq()I

    move-result v14

    .line 976
    .local v14, "mLteRsrq":I
    invoke-virtual/range {v25 .. v25}, Landroid/telephony/SignalStrength;->getLteRssnr()I

    move-result v15

    .line 977
    .local v15, "mLteRssnr":I
    invoke-virtual/range {v25 .. v25}, Landroid/telephony/SignalStrength;->getLteCqi()I

    move-result v16

    .line 978
    .local v16, "mLteCqi":I
    invoke-virtual/range {v25 .. v25}, Landroid/telephony/SignalStrength;->getTdScdmaDbm()I

    move-result v26

    .line 980
    .local v26, "mTdScdmaRscp":I
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/ServiceStateTracker;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v4}, Landroid/telephony/ServiceState;->getRilVoiceRadioTechnology()I

    move-result v31

    .line 981
    .local v31, "radiotype":I
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/ServiceStateTracker;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v4}, Landroid/telephony/ServiceState;->getRilDataRadioTechnology()I

    move-result v21

    .line 982
    .local v21, "dataradiotype":I
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Smooth VoiceRadiotype : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move/from16 v0, v31

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/android/internal/telephony/ServiceStateTracker;->mSS:Landroid/telephony/ServiceState;

    invoke-static/range {v31 .. v31}, Landroid/telephony/ServiceState;->rilRadioTechnologyToString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ";  dataradiotype : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move/from16 v0, v21

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/android/internal/telephony/ServiceStateTracker;->mSS:Landroid/telephony/ServiceState;

    invoke-static/range {v21 .. v21}, Landroid/telephony/ServiceState;->rilRadioTechnologyToString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    move-object/from16 v0, p0

    invoke-virtual {v0, v4}, Lcom/android/internal/telephony/ServiceStateTracker;->log(Ljava/lang/String;)V

    .line 985
    move-object/from16 v0, p0

    iget v4, v0, Lcom/android/internal/telephony/ServiceStateTracker;->mRegisterDelay:I

    if-eqz v4, :cond_1

    .line 986
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Smooth mRegisterDelay:"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move-object/from16 v0, p0

    iget v5, v0, Lcom/android/internal/telephony/ServiceStateTracker;->mRegisterDelay:I

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    move-object/from16 v0, p0

    invoke-virtual {v0, v4}, Lcom/android/internal/telephony/ServiceStateTracker;->log(Ljava/lang/String;)V

    .line 987
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ServiceStateTracker;->notifySignalStrength()Z

    move-result v4

    .line 1088
    :goto_1
    return v4

    .line 962
    .end local v6    # "mGsmBitErrorRate":I
    .end local v8    # "mCdmaEcio":I
    .end local v9    # "mEvdoDbm":I
    .end local v10    # "mEvdoEcio":I
    .end local v11    # "mEvdoSnr":I
    .end local v12    # "mLteSignalStrength":I
    .end local v14    # "mLteRsrq":I
    .end local v15    # "mLteRssnr":I
    .end local v16    # "mLteCqi":I
    .end local v21    # "dataradiotype":I
    .end local v22    # "mCdmaDbm":I
    .end local v23    # "mGsmSignalStrength":I
    .end local v24    # "mLteRsrp":I
    .end local v26    # "mTdScdmaRscp":I
    .end local v31    # "radiotype":I
    :cond_0
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "onSignalStrengthResult() Exception from RIL : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move-object/from16 v0, p1

    iget-object v5, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    move-object/from16 v0, p0

    invoke-virtual {v0, v4}, Lcom/android/internal/telephony/ServiceStateTracker;->log(Ljava/lang/String;)V

    .line 963
    new-instance v25, Landroid/telephony/SignalStrength;

    .end local v25    # "mSignalStrengthTmp":Landroid/telephony/SignalStrength;
    move-object/from16 v0, v25

    move/from16 v1, p2

    invoke-direct {v0, v1}, Landroid/telephony/SignalStrength;-><init>(Z)V

    .restart local v25    # "mSignalStrengthTmp":Landroid/telephony/SignalStrength;
    goto/16 :goto_0

    .line 990
    .restart local v6    # "mGsmBitErrorRate":I
    .restart local v8    # "mCdmaEcio":I
    .restart local v9    # "mEvdoDbm":I
    .restart local v10    # "mEvdoEcio":I
    .restart local v11    # "mEvdoSnr":I
    .restart local v12    # "mLteSignalStrength":I
    .restart local v14    # "mLteRsrq":I
    .restart local v15    # "mLteRssnr":I
    .restart local v16    # "mLteCqi":I
    .restart local v21    # "dataradiotype":I
    .restart local v22    # "mCdmaDbm":I
    .restart local v23    # "mGsmSignalStrength":I
    .restart local v24    # "mLteRsrp":I
    .restart local v26    # "mTdScdmaRscp":I
    .restart local v31    # "radiotype":I
    :cond_1
    move-object/from16 v0, p0

    move/from16 v1, v31

    invoke-direct {v0, v1}, Lcom/android/internal/telephony/ServiceStateTracker;->iSGsmTechnology(I)Z

    move-result v4

    if-eqz v4, :cond_5

    .line 991
    invoke-virtual/range {v25 .. v25}, Landroid/telephony/SignalStrength;->getGsmLevel()I

    move-result v27

    .line 992
    invoke-virtual/range {v28 .. v28}, Landroid/telephony/SignalStrength;->getGsmLevel()I

    move-result v29

    .line 993
    sub-int v20, v27, v29

    .line 994
    invoke-virtual/range {v28 .. v28}, Landroid/telephony/SignalStrength;->getGsmSignalStrength()I

    move-result v30

    .line 995
    const/16 v4, 0x63

    move/from16 v0, v30

    if-eq v0, v4, :cond_4

    if-eqz v20, :cond_4

    .line 996
    sub-int v19, v23, v30

    .line 997
    move-object/from16 v0, p0

    iget v4, v0, Lcom/android/internal/telephony/ServiceStateTracker;->mGsmSignalStrengthNew:I

    move-object/from16 v0, p0

    move/from16 v1, v23

    move/from16 v2, v19

    invoke-direct {v0, v1, v4, v2}, Lcom/android/internal/telephony/ServiceStateTracker;->getGsmSignalStrengthNew(III)I

    move-result v4

    move-object/from16 v0, p0

    iput v4, v0, Lcom/android/internal/telephony/ServiceStateTracker;->mGsmSignalStrengthNew:I

    .line 1001
    :goto_2
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Smooth +++ gsm: newlevel = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move/from16 v0, v27

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "; oldlevel = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move/from16 v0, v29

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "; mGsmSignalStrengthNew = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move-object/from16 v0, p0

    iget v5, v0, Lcom/android/internal/telephony/ServiceStateTracker;->mGsmSignalStrengthNew:I

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "; mGsmSignalStrength = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move/from16 v0, v23

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    move-object/from16 v0, p0

    invoke-virtual {v0, v4}, Lcom/android/internal/telephony/ServiceStateTracker;->log(Ljava/lang/String;)V

    .line 1002
    move/from16 v0, v26

    move-object/from16 v1, p0

    iput v0, v1, Lcom/android/internal/telephony/ServiceStateTracker;->mTdScdmaRscpNew:I

    .line 1003
    move/from16 v0, v22

    move-object/from16 v1, p0

    iput v0, v1, Lcom/android/internal/telephony/ServiceStateTracker;->mCdmaDbmNew:I

    .line 1040
    :goto_3
    move-object/from16 v0, p0

    move/from16 v1, v21

    invoke-direct {v0, v1}, Lcom/android/internal/telephony/ServiceStateTracker;->iSLTETechnology(I)Z

    move-result v4

    if-eqz v4, :cond_b

    .line 1041
    invoke-virtual/range {v25 .. v25}, Landroid/telephony/SignalStrength;->getLteLevel()I

    move-result v27

    .line 1042
    invoke-virtual/range {v28 .. v28}, Landroid/telephony/SignalStrength;->getLteLevel()I

    move-result v29

    .line 1043
    sub-int v20, v27, v29

    .line 1044
    invoke-virtual/range {v28 .. v28}, Landroid/telephony/SignalStrength;->getLteRsrp()I

    move-result v30

    .line 1045
    const v4, 0x7fffffff

    move/from16 v0, v30

    if-eq v0, v4, :cond_a

    if-eqz v20, :cond_a

    .line 1046
    sub-int v19, v24, v30

    .line 1047
    move-object/from16 v0, p0

    iget v4, v0, Lcom/android/internal/telephony/ServiceStateTracker;->mLteRsrpNew:I

    move-object/from16 v0, p0

    move/from16 v1, v24

    move/from16 v2, v19

    invoke-direct {v0, v1, v4, v2}, Lcom/android/internal/telephony/ServiceStateTracker;->geLTESignalStrengthNew(III)I

    move-result v4

    move-object/from16 v0, p0

    iput v4, v0, Lcom/android/internal/telephony/ServiceStateTracker;->mLteRsrpNew:I

    .line 1048
    move-object/from16 v0, p0

    iget v4, v0, Lcom/android/internal/telephony/ServiceStateTracker;->ifinalSmoothType:I

    if-nez v4, :cond_2

    .line 1049
    const/4 v4, 0x1

    move-object/from16 v0, p0

    iput v4, v0, Lcom/android/internal/telephony/ServiceStateTracker;->ifinalSmoothType:I

    .line 1054
    :cond_2
    :goto_4
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Smooth +++ lte: newlevel = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move/from16 v0, v27

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "; oldlevel = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move/from16 v0, v29

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "; mLteRsrpNew = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move-object/from16 v0, p0

    iget v5, v0, Lcom/android/internal/telephony/ServiceStateTracker;->mLteRsrpNew:I

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "; mLteRsrp = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move/from16 v0, v24

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    move-object/from16 v0, p0

    invoke-virtual {v0, v4}, Lcom/android/internal/telephony/ServiceStateTracker;->log(Ljava/lang/String;)V

    .line 1059
    :goto_5
    const/4 v4, 0x1

    move-object/from16 v0, p0

    iget v5, v0, Lcom/android/internal/telephony/ServiceStateTracker;->ifinalSmoothType:I

    if-ne v4, v5, :cond_c

    .line 1062
    const-string v4, "Smooth Timer ---- up"

    move-object/from16 v0, p0

    invoke-virtual {v0, v4}, Lcom/android/internal/telephony/ServiceStateTracker;->log(Ljava/lang/String;)V

    .line 1063
    const/16 v4, 0x7d0

    const-wide/16 v32, 0xbb8

    move-object/from16 v0, p0

    move-wide/from16 v1, v32

    invoke-virtual {v0, v4, v1, v2}, Lcom/android/internal/telephony/ServiceStateTracker;->sendEmptyMessageDelayed(IJ)Z

    .line 1077
    :cond_3
    :goto_6
    new-instance v4, Landroid/telephony/SignalStrength;

    move-object/from16 v0, p0

    iget v5, v0, Lcom/android/internal/telephony/ServiceStateTracker;->mGsmSignalStrengthNew:I

    move-object/from16 v0, p0

    iget v7, v0, Lcom/android/internal/telephony/ServiceStateTracker;->mCdmaDbmNew:I

    move-object/from16 v0, p0

    iget v13, v0, Lcom/android/internal/telephony/ServiceStateTracker;->mLteRsrpNew:I

    move-object/from16 v0, p0

    iget v0, v0, Lcom/android/internal/telephony/ServiceStateTracker;->mTdScdmaRscpNew:I

    move/from16 v17, v0

    move/from16 v18, p2

    invoke-direct/range {v4 .. v18}, Landroid/telephony/SignalStrength;-><init>(IIIIIIIIIIIIIZ)V

    move-object/from16 v0, p0

    iput-object v4, v0, Lcom/android/internal/telephony/ServiceStateTracker;->mSignalStrength:Landroid/telephony/SignalStrength;

    .line 1083
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Smooth --- : newlevel  gsm= "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/android/internal/telephony/ServiceStateTracker;->mSignalStrength:Landroid/telephony/SignalStrength;

    invoke-virtual {v5}, Landroid/telephony/SignalStrength;->getGsmLevel()I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "; td=  "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/android/internal/telephony/ServiceStateTracker;->mSignalStrength:Landroid/telephony/SignalStrength;

    invoke-virtual {v5}, Landroid/telephony/SignalStrength;->getTdScdmaLevel()I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "; cdma=  "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/android/internal/telephony/ServiceStateTracker;->mSignalStrength:Landroid/telephony/SignalStrength;

    invoke-virtual {v5}, Landroid/telephony/SignalStrength;->getCdmaLevel()I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "; lte= "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/android/internal/telephony/ServiceStateTracker;->mSignalStrength:Landroid/telephony/SignalStrength;

    invoke-virtual {v5}, Landroid/telephony/SignalStrength;->getLteLevel()I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    move-object/from16 v0, p0

    invoke-virtual {v0, v4}, Lcom/android/internal/telephony/ServiceStateTracker;->log(Ljava/lang/String;)V

    .line 1088
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ServiceStateTracker;->notifySignalStrength()Z

    move-result v4

    goto/16 :goto_1

    .line 999
    :cond_4
    move/from16 v0, v23

    move-object/from16 v1, p0

    iput v0, v1, Lcom/android/internal/telephony/ServiceStateTracker;->mGsmSignalStrengthNew:I

    goto/16 :goto_2

    .line 1004
    :cond_5
    move-object/from16 v0, p0

    move/from16 v1, v31

    invoke-direct {v0, v1}, Lcom/android/internal/telephony/ServiceStateTracker;->iSTDTechnology(I)Z

    move-result v4

    if-eqz v4, :cond_7

    .line 1005
    invoke-virtual/range {v25 .. v25}, Landroid/telephony/SignalStrength;->getTdScdmaLevel()I

    move-result v27

    .line 1006
    invoke-virtual/range {v28 .. v28}, Landroid/telephony/SignalStrength;->getTdScdmaLevel()I

    move-result v29

    .line 1007
    sub-int v20, v27, v29

    .line 1008
    invoke-virtual/range {v28 .. v28}, Landroid/telephony/SignalStrength;->getTdScdmaDbm()I

    move-result v30

    .line 1009
    const v4, 0x7fffffff

    move/from16 v0, v30

    if-eq v0, v4, :cond_6

    if-eqz v20, :cond_6

    .line 1010
    sub-int v19, v26, v30

    .line 1011
    move-object/from16 v0, p0

    iget v4, v0, Lcom/android/internal/telephony/ServiceStateTracker;->mTdScdmaRscpNew:I

    move-object/from16 v0, p0

    move/from16 v1, v26

    move/from16 v2, v19

    invoke-direct {v0, v1, v4, v2}, Lcom/android/internal/telephony/ServiceStateTracker;->geTDSignalStrengthNew(III)I

    move-result v4

    move-object/from16 v0, p0

    iput v4, v0, Lcom/android/internal/telephony/ServiceStateTracker;->mTdScdmaRscpNew:I

    .line 1015
    :goto_7
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Smooth +++ td: newlevel = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move/from16 v0, v27

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "; oldlevel = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move/from16 v0, v29

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "; mTdScdmaRscpNew = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move-object/from16 v0, p0

    iget v5, v0, Lcom/android/internal/telephony/ServiceStateTracker;->mTdScdmaRscpNew:I

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "; mTdScdmaRscp = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move/from16 v0, v26

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    move-object/from16 v0, p0

    invoke-virtual {v0, v4}, Lcom/android/internal/telephony/ServiceStateTracker;->log(Ljava/lang/String;)V

    .line 1017
    move/from16 v0, v23

    move-object/from16 v1, p0

    iput v0, v1, Lcom/android/internal/telephony/ServiceStateTracker;->mGsmSignalStrengthNew:I

    .line 1018
    move/from16 v0, v22

    move-object/from16 v1, p0

    iput v0, v1, Lcom/android/internal/telephony/ServiceStateTracker;->mCdmaDbmNew:I

    goto/16 :goto_3

    .line 1013
    :cond_6
    move/from16 v0, v26

    move-object/from16 v1, p0

    iput v0, v1, Lcom/android/internal/telephony/ServiceStateTracker;->mTdScdmaRscpNew:I

    goto :goto_7

    .line 1019
    :cond_7
    move-object/from16 v0, p0

    move/from16 v1, v31

    invoke-direct {v0, v1}, Lcom/android/internal/telephony/ServiceStateTracker;->iSCDMATechnology(I)Z

    move-result v4

    if-eqz v4, :cond_9

    .line 1020
    invoke-virtual/range {v25 .. v25}, Landroid/telephony/SignalStrength;->getCdmaLevel()I

    move-result v27

    .line 1021
    invoke-virtual/range {v28 .. v28}, Landroid/telephony/SignalStrength;->getCdmaLevel()I

    move-result v29

    .line 1022
    sub-int v20, v27, v29

    .line 1023
    invoke-virtual/range {v28 .. v28}, Landroid/telephony/SignalStrength;->getCdmaDbm()I

    move-result v30

    .line 1024
    const v4, 0x7fffffff

    move/from16 v0, v30

    if-eq v0, v4, :cond_8

    if-eqz v20, :cond_8

    .line 1025
    sub-int v19, v22, v30

    .line 1026
    move-object/from16 v0, p0

    iget v4, v0, Lcom/android/internal/telephony/ServiceStateTracker;->mCdmaDbmNew:I

    move-object/from16 v0, p0

    move/from16 v1, v22

    move/from16 v2, v19

    invoke-direct {v0, v1, v4, v2}, Lcom/android/internal/telephony/ServiceStateTracker;->geCDMASignalStrengthNew(III)I

    move-result v4

    move-object/from16 v0, p0

    iput v4, v0, Lcom/android/internal/telephony/ServiceStateTracker;->mCdmaDbmNew:I

    .line 1030
    :goto_8
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Smooth +++ cdma: newlevel = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move/from16 v0, v27

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "; oldlevel = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move/from16 v0, v29

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "; mCdmaDbmNew = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move-object/from16 v0, p0

    iget v5, v0, Lcom/android/internal/telephony/ServiceStateTracker;->mCdmaDbmNew:I

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "; mCdmaDbm = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move/from16 v0, v22

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    move-object/from16 v0, p0

    invoke-virtual {v0, v4}, Lcom/android/internal/telephony/ServiceStateTracker;->log(Ljava/lang/String;)V

    .line 1032
    move/from16 v0, v23

    move-object/from16 v1, p0

    iput v0, v1, Lcom/android/internal/telephony/ServiceStateTracker;->mGsmSignalStrengthNew:I

    .line 1033
    move/from16 v0, v26

    move-object/from16 v1, p0

    iput v0, v1, Lcom/android/internal/telephony/ServiceStateTracker;->mTdScdmaRscpNew:I

    goto/16 :goto_3

    .line 1028
    :cond_8
    move/from16 v0, v22

    move-object/from16 v1, p0

    iput v0, v1, Lcom/android/internal/telephony/ServiceStateTracker;->mCdmaDbmNew:I

    goto :goto_8

    .line 1035
    :cond_9
    move/from16 v0, v23

    move-object/from16 v1, p0

    iput v0, v1, Lcom/android/internal/telephony/ServiceStateTracker;->mGsmSignalStrengthNew:I

    .line 1036
    move/from16 v0, v26

    move-object/from16 v1, p0

    iput v0, v1, Lcom/android/internal/telephony/ServiceStateTracker;->mTdScdmaRscpNew:I

    .line 1037
    move/from16 v0, v22

    move-object/from16 v1, p0

    iput v0, v1, Lcom/android/internal/telephony/ServiceStateTracker;->mCdmaDbmNew:I

    goto/16 :goto_3

    .line 1052
    :cond_a
    move/from16 v0, v24

    move-object/from16 v1, p0

    iput v0, v1, Lcom/android/internal/telephony/ServiceStateTracker;->mLteRsrpNew:I

    goto/16 :goto_4

    .line 1056
    :cond_b
    move/from16 v0, v24

    move-object/from16 v1, p0

    iput v0, v1, Lcom/android/internal/telephony/ServiceStateTracker;->mLteRsrpNew:I

    goto/16 :goto_5

    .line 1065
    :cond_c
    const/4 v4, 0x2

    move-object/from16 v0, p0

    iget v5, v0, Lcom/android/internal/telephony/ServiceStateTracker;->ifinalSmoothType:I

    if-ne v4, v5, :cond_3

    .line 1068
    const-string v4, "Smooth Timer ---- down"

    move-object/from16 v0, p0

    invoke-virtual {v0, v4}, Lcom/android/internal/telephony/ServiceStateTracker;->log(Ljava/lang/String;)V

    .line 1069
    const/16 v4, 0x7d0

    const-wide/16 v32, 0xfa0

    move-object/from16 v0, p0

    move-wide/from16 v1, v32

    invoke-virtual {v0, v4, v1, v2}, Lcom/android/internal/telephony/ServiceStateTracker;->sendEmptyMessageDelayed(IJ)Z

    goto/16 :goto_6
.end method

.method protected abstract onUpdateIccAvailability()V
.end method

.method public abstract pollState()V
.end method

.method public powerOffRadioSafely(Lcom/android/internal/telephony/dataconnection/DcTrackerBase;)V
    .locals 6
    .param p1, "dcTracker"    # Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    .prologue
    .line 764
    monitor-enter p0

    .line 765
    :try_start_0
    iget-boolean v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPendingRadioPowerOffAfterDataOff:Z

    if-nez v4, :cond_2

    .line 770
    iget-object v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPhoneBase:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v4}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v4

    invoke-virtual {v4}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v4

    const v5, 0x1070049

    invoke-virtual {v4, v5}, Landroid/content/res/Resources;->getStringArray(I)[Ljava/lang/String;

    move-result-object v3

    .line 772
    .local v3, "networkNotClearData":[Ljava/lang/String;
    iget-object v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v4}, Landroid/telephony/ServiceState;->getOperatorNumeric()Ljava/lang/String;

    move-result-object v0

    .line 773
    .local v0, "currentNetwork":Ljava/lang/String;
    if-eqz v3, :cond_1

    if-eqz v0, :cond_1

    .line 774
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v4, v3

    if-ge v1, v4, :cond_1

    .line 775
    aget-object v4, v3, v1

    invoke-virtual {v0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 778
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Not disconnecting data for "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Lcom/android/internal/telephony/ServiceStateTracker;->log(Ljava/lang/String;)V

    .line 779
    invoke-virtual {p0}, Lcom/android/internal/telephony/ServiceStateTracker;->hangupAndPowerOff()V

    .line 780
    monitor-exit p0

    .line 806
    .end local v0    # "currentNetwork":Ljava/lang/String;
    .end local v1    # "i":I
    .end local v3    # "networkNotClearData":[Ljava/lang/String;
    :goto_1
    return-void

    .line 774
    .restart local v0    # "currentNetwork":Ljava/lang/String;
    .restart local v1    # "i":I
    .restart local v3    # "networkNotClearData":[Ljava/lang/String;
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 786
    .end local v1    # "i":I
    :cond_1
    invoke-virtual {p1}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->isDisconnected()Z

    move-result v4

    if-eqz v4, :cond_3

    .line 788
    const-string v4, "radioTurnedOff"

    invoke-virtual {p1, v4}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->cleanUpAllConnections(Ljava/lang/String;)V

    .line 789
    const-string v4, "Data disconnected, turn off radio right away."

    invoke-virtual {p0, v4}, Lcom/android/internal/telephony/ServiceStateTracker;->log(Ljava/lang/String;)V

    .line 790
    invoke-virtual {p0}, Lcom/android/internal/telephony/ServiceStateTracker;->hangupAndPowerOff()V

    .line 805
    .end local v0    # "currentNetwork":Ljava/lang/String;
    .end local v3    # "networkNotClearData":[Ljava/lang/String;
    :cond_2
    :goto_2
    monitor-exit p0

    goto :goto_1

    :catchall_0
    move-exception v4

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v4

    .line 792
    .restart local v0    # "currentNetwork":Ljava/lang/String;
    .restart local v3    # "networkNotClearData":[Ljava/lang/String;
    :cond_3
    :try_start_1
    const-string v4, "radioTurnedOff"

    invoke-virtual {p1, v4}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->cleanUpAllConnections(Ljava/lang/String;)V

    .line 793
    invoke-static {p0}, Landroid/os/Message;->obtain(Landroid/os/Handler;)Landroid/os/Message;

    move-result-object v2

    .line 794
    .local v2, "msg":Landroid/os/Message;
    const/16 v4, 0x26

    iput v4, v2, Landroid/os/Message;->what:I

    .line 795
    iget v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPendingRadioPowerOffAfterDataOffTag:I

    add-int/lit8 v4, v4, 0x1

    iput v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPendingRadioPowerOffAfterDataOffTag:I

    iput v4, v2, Landroid/os/Message;->arg1:I

    .line 796
    const-wide/16 v4, 0x7530

    invoke-virtual {p0, v2, v4, v5}, Lcom/android/internal/telephony/ServiceStateTracker;->sendMessageDelayed(Landroid/os/Message;J)Z

    move-result v4

    if-eqz v4, :cond_4

    .line 797
    const-string v4, "Wait upto 30s for data to disconnect, then turn off radio."

    invoke-virtual {p0, v4}, Lcom/android/internal/telephony/ServiceStateTracker;->log(Ljava/lang/String;)V

    .line 798
    const/4 v4, 0x1

    iput-boolean v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPendingRadioPowerOffAfterDataOff:Z

    goto :goto_2

    .line 800
    :cond_4
    const-string v4, "Cannot send delayed Msg, turn off radio right away."

    invoke-virtual {p0, v4}, Lcom/android/internal/telephony/ServiceStateTracker;->log(Ljava/lang/String;)V

    .line 801
    invoke-virtual {p0}, Lcom/android/internal/telephony/ServiceStateTracker;->hangupAndPowerOff()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_2
.end method

.method protected processIwlanToWwanTransition(Landroid/telephony/ServiceState;)V
    .locals 2
    .param p1, "ss"    # Landroid/telephony/ServiceState;

    .prologue
    .line 1328
    invoke-virtual {p0}, Lcom/android/internal/telephony/ServiceStateTracker;->isIwlanFeatureAvailable()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p1}, Landroid/telephony/ServiceState;->getRilDataRadioTechnology()I

    move-result v0

    const/16 v1, 0x12

    if-eq v0, v1, :cond_0

    invoke-virtual {p1}, Landroid/telephony/ServiceState;->getRilDataRadioTechnology()I

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p1}, Landroid/telephony/ServiceState;->getDataRegState()I

    move-result v0

    if-nez v0, :cond_0

    iget-boolean v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mIwlanRatAvailable:Z

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    .line 1336
    const-string v0, "pollStateDone: Wifi connected and moved out of iwlan and wwan is attached."

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/ServiceStateTracker;->log(Ljava/lang/String;)V

    .line 1338
    iget-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mAttachedRegistrants:Landroid/os/RegistrantList;

    invoke-virtual {v0}, Landroid/os/RegistrantList;->notifyRegistrants()V

    .line 1341
    :cond_0
    return-void
.end method

.method public processPendingRadioPowerOffAfterDataOff()Z
    .locals 2

    .prologue
    const/4 v0, 0x0

    .line 814
    monitor-enter p0

    .line 815
    :try_start_0
    iget-boolean v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPendingRadioPowerOffAfterDataOff:Z

    if-eqz v1, :cond_0

    .line 816
    const-string v0, "Process pending request to turn radio off."

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/ServiceStateTracker;->log(Ljava/lang/String;)V

    .line 817
    iget v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPendingRadioPowerOffAfterDataOffTag:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPendingRadioPowerOffAfterDataOffTag:I

    .line 818
    invoke-virtual {p0}, Lcom/android/internal/telephony/ServiceStateTracker;->hangupAndPowerOff()V

    .line 819
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPendingRadioPowerOffAfterDataOff:Z

    .line 820
    const/4 v0, 0x1

    monitor-exit p0

    .line 822
    :goto_0
    return v0

    :cond_0
    monitor-exit p0

    goto :goto_0

    .line 823
    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public reRegisterNetwork(Landroid/os/Message;)V
    .locals 2
    .param p1, "onComplete"    # Landroid/os/Message;

    .prologue
    .line 505
    iget-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    const/16 v1, 0x13

    invoke-virtual {p0, v1, p1}, Lcom/android/internal/telephony/ServiceStateTracker;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/android/internal/telephony/CommandsInterface;->getPreferredNetworkType(Landroid/os/Message;)V

    .line 507
    return-void
.end method

.method public registerForDataConnectionAttached(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 2
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    .line 655
    new-instance v0, Landroid/os/Registrant;

    invoke-direct {v0, p1, p2, p3}, Landroid/os/Registrant;-><init>(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 656
    .local v0, "r":Landroid/os/Registrant;
    iget-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mAttachedRegistrants:Landroid/os/RegistrantList;

    invoke-virtual {v1, v0}, Landroid/os/RegistrantList;->add(Landroid/os/Registrant;)V

    .line 658
    invoke-virtual {p0}, Lcom/android/internal/telephony/ServiceStateTracker;->getCurrentDataConnectionState()I

    move-result v1

    if-nez v1, :cond_0

    .line 659
    invoke-virtual {v0}, Landroid/os/Registrant;->notifyRegistrant()V

    .line 661
    :cond_0
    return-void
.end method

.method public registerForDataConnectionDetached(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 2
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    .line 673
    new-instance v0, Landroid/os/Registrant;

    invoke-direct {v0, p1, p2, p3}, Landroid/os/Registrant;-><init>(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 674
    .local v0, "r":Landroid/os/Registrant;
    iget-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mDetachedRegistrants:Landroid/os/RegistrantList;

    invoke-virtual {v1, v0}, Landroid/os/RegistrantList;->add(Landroid/os/Registrant;)V

    .line 676
    invoke-virtual {p0}, Lcom/android/internal/telephony/ServiceStateTracker;->getCurrentDataConnectionState()I

    move-result v1

    if-eqz v1, :cond_0

    .line 677
    invoke-virtual {v0}, Landroid/os/Registrant;->notifyRegistrant()V

    .line 679
    :cond_0
    return-void
.end method

.method public registerForDataRegStateOrRatChanged(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 2
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    .line 694
    new-instance v0, Landroid/os/Registrant;

    invoke-direct {v0, p1, p2, p3}, Landroid/os/Registrant;-><init>(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 695
    .local v0, "r":Landroid/os/Registrant;
    iget-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mDataRegStateOrRatChangedRegistrants:Landroid/os/RegistrantList;

    invoke-virtual {v1, v0}, Landroid/os/RegistrantList;->add(Landroid/os/Registrant;)V

    .line 696
    invoke-virtual {p0}, Lcom/android/internal/telephony/ServiceStateTracker;->notifyDataRegStateRilRadioTechnologyChanged()V

    .line 697
    return-void
.end method

.method public registerForDataRoamingOff(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 2
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    .line 483
    new-instance v0, Landroid/os/Registrant;

    invoke-direct {v0, p1, p2, p3}, Landroid/os/Registrant;-><init>(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 484
    .local v0, "r":Landroid/os/Registrant;
    iget-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mDataRoamingOffRegistrants:Landroid/os/RegistrantList;

    invoke-virtual {v1, v0}, Landroid/os/RegistrantList;->add(Landroid/os/Registrant;)V

    .line 486
    iget-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v1}, Landroid/telephony/ServiceState;->getDataRoaming()Z

    move-result v1

    if-nez v1, :cond_0

    .line 487
    invoke-virtual {v0}, Landroid/os/Registrant;->notifyRegistrant()V

    .line 489
    :cond_0
    return-void
.end method

.method public registerForDataRoamingOn(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 2
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    .line 462
    new-instance v0, Landroid/os/Registrant;

    invoke-direct {v0, p1, p2, p3}, Landroid/os/Registrant;-><init>(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 463
    .local v0, "r":Landroid/os/Registrant;
    iget-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mDataRoamingOnRegistrants:Landroid/os/RegistrantList;

    invoke-virtual {v1, v0}, Landroid/os/RegistrantList;->add(Landroid/os/Registrant;)V

    .line 465
    iget-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v1}, Landroid/telephony/ServiceState;->getDataRoaming()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 466
    invoke-virtual {v0}, Landroid/os/Registrant;->notifyRegistrant()V

    .line 468
    :cond_0
    return-void
.end method

.method public registerForNetworkAttached(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 2
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    .line 709
    new-instance v0, Landroid/os/Registrant;

    invoke-direct {v0, p1, p2, p3}, Landroid/os/Registrant;-><init>(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 711
    .local v0, "r":Landroid/os/Registrant;
    iget-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mNetworkAttachedRegistrants:Landroid/os/RegistrantList;

    invoke-virtual {v1, v0}, Landroid/os/RegistrantList;->add(Landroid/os/Registrant;)V

    .line 712
    iget-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v1}, Landroid/telephony/ServiceState;->getVoiceRegState()I

    move-result v1

    if-nez v1, :cond_0

    .line 713
    invoke-virtual {v0}, Landroid/os/Registrant;->notifyRegistrant()V

    .line 715
    :cond_0
    return-void
.end method

.method public registerForPsRestrictedDisabled(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 2
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    .line 746
    new-instance v0, Landroid/os/Registrant;

    invoke-direct {v0, p1, p2, p3}, Landroid/os/Registrant;-><init>(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 747
    .local v0, "r":Landroid/os/Registrant;
    iget-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPsRestrictDisabledRegistrants:Landroid/os/RegistrantList;

    invoke-virtual {v1, v0}, Landroid/os/RegistrantList;->add(Landroid/os/Registrant;)V

    .line 749
    iget-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mRestrictedState:Lcom/android/internal/telephony/RestrictedState;

    invoke-virtual {v1}, Lcom/android/internal/telephony/RestrictedState;->isPsRestricted()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 750
    invoke-virtual {v0}, Landroid/os/Registrant;->notifyRegistrant()V

    .line 752
    :cond_0
    return-void
.end method

.method public registerForPsRestrictedEnabled(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 2
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    .line 727
    new-instance v0, Landroid/os/Registrant;

    invoke-direct {v0, p1, p2, p3}, Landroid/os/Registrant;-><init>(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 728
    .local v0, "r":Landroid/os/Registrant;
    iget-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPsRestrictEnabledRegistrants:Landroid/os/RegistrantList;

    invoke-virtual {v1, v0}, Landroid/os/RegistrantList;->add(Landroid/os/Registrant;)V

    .line 730
    iget-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mRestrictedState:Lcom/android/internal/telephony/RestrictedState;

    invoke-virtual {v1}, Lcom/android/internal/telephony/RestrictedState;->isPsRestricted()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 731
    invoke-virtual {v0}, Landroid/os/Registrant;->notifyRegistrant()V

    .line 733
    :cond_0
    return-void
.end method

.method public registerForVoiceRoamingOff(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 2
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    .line 441
    new-instance v0, Landroid/os/Registrant;

    invoke-direct {v0, p1, p2, p3}, Landroid/os/Registrant;-><init>(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 442
    .local v0, "r":Landroid/os/Registrant;
    iget-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mVoiceRoamingOffRegistrants:Landroid/os/RegistrantList;

    invoke-virtual {v1, v0}, Landroid/os/RegistrantList;->add(Landroid/os/Registrant;)V

    .line 444
    iget-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v1}, Landroid/telephony/ServiceState;->getVoiceRoaming()Z

    move-result v1

    if-nez v1, :cond_0

    .line 445
    invoke-virtual {v0}, Landroid/os/Registrant;->notifyRegistrant()V

    .line 447
    :cond_0
    return-void
.end method

.method public registerForVoiceRoamingOn(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 2
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    .line 420
    new-instance v0, Landroid/os/Registrant;

    invoke-direct {v0, p1, p2, p3}, Landroid/os/Registrant;-><init>(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 421
    .local v0, "r":Landroid/os/Registrant;
    iget-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mVoiceRoamingOnRegistrants:Landroid/os/RegistrantList;

    invoke-virtual {v1, v0}, Landroid/os/RegistrantList;->add(Landroid/os/Registrant;)V

    .line 423
    iget-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v1}, Landroid/telephony/ServiceState;->getVoiceRoaming()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 424
    invoke-virtual {v0}, Landroid/os/Registrant;->notifyRegistrant()V

    .line 426
    :cond_0
    return-void
.end method

.method requestShutdown()V
    .locals 2

    .prologue
    const/4 v1, 0x1

    .line 339
    iget-boolean v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mDeviceShuttingDown:Z

    if-ne v0, v1, :cond_0

    .line 343
    :goto_0
    return-void

    .line 340
    :cond_0
    iput-boolean v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mDeviceShuttingDown:Z

    .line 341
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mDesiredPowerState:Z

    .line 342
    invoke-virtual {p0}, Lcom/android/internal/telephony/ServiceStateTracker;->setPowerStateToDesired()V

    goto :goto_0
.end method

.method protected resetServiceStateInIwlanMode()V
    .locals 4

    .prologue
    const/16 v3, 0x12

    .line 1348
    iget-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v1}, Lcom/android/internal/telephony/CommandsInterface;->getRadioState()Lcom/android/internal/telephony/CommandsInterface$RadioState;

    move-result-object v1

    sget-object v2, Lcom/android/internal/telephony/CommandsInterface$RadioState;->RADIO_OFF:Lcom/android/internal/telephony/CommandsInterface$RadioState;

    if-ne v1, v2, :cond_1

    .line 1349
    const/4 v0, 0x0

    .line 1350
    .local v0, "resetIwlanRatVal":Z
    const-string v1, "set service state as POWER_OFF"

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/ServiceStateTracker;->log(Ljava/lang/String;)V

    .line 1351
    invoke-virtual {p0}, Lcom/android/internal/telephony/ServiceStateTracker;->isIwlanFeatureAvailable()Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mNewSS:Landroid/telephony/ServiceState;

    invoke-virtual {v1}, Landroid/telephony/ServiceState;->getRilDataRadioTechnology()I

    move-result v1

    if-ne v3, v1, :cond_0

    .line 1354
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "pollStateDone: mNewSS = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mNewSS:Landroid/telephony/ServiceState;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/ServiceStateTracker;->log(Ljava/lang/String;)V

    .line 1355
    const-string v1, "pollStateDone: reset iwlan RAT value"

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/ServiceStateTracker;->log(Ljava/lang/String;)V

    .line 1356
    const/4 v0, 0x1

    .line 1358
    :cond_0
    iget-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mNewSS:Landroid/telephony/ServiceState;

    invoke-virtual {v1}, Landroid/telephony/ServiceState;->setStateOff()V

    .line 1359
    if-eqz v0, :cond_1

    .line 1360
    iget-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mNewSS:Landroid/telephony/ServiceState;

    invoke-virtual {v1, v3}, Landroid/telephony/ServiceState;->setRilDataRadioTechnology(I)V

    .line 1361
    iget-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mNewSS:Landroid/telephony/ServiceState;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/telephony/ServiceState;->setDataRegState(I)V

    .line 1362
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "pollStateDone: mNewSS = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mNewSS:Landroid/telephony/ServiceState;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/ServiceStateTracker;->log(Ljava/lang/String;)V

    .line 1366
    .end local v0    # "resetIwlanRatVal":Z
    :cond_1
    return-void
.end method

.method protected sendSpnStringsBroadcastIfNeeded(Ljava/lang/String;ZLjava/lang/String;Z)V
    .locals 8
    .param p1, "plmn"    # Ljava/lang/String;
    .param p2, "showPlmn"    # Z
    .param p3, "spn"    # Ljava/lang/String;
    .param p4, "showSpn"    # Z

    .prologue
    .line 1434
    iget-object v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPhoneBase:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v4}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v0

    .line 1435
    .local v0, "context":Landroid/content/Context;
    iget-object v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPhoneBase:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v4}, Lcom/android/internal/telephony/PhoneBase;->getPhoneId()I

    move-result v2

    .line 1436
    .local v2, "phoneId":I
    iget-object v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPhoneBase:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v4}, Lcom/android/internal/telephony/PhoneBase;->getSubId()I

    move-result v3

    .line 1438
    .local v3, "subId":I
    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v4

    const v5, 0x11200a3

    invoke-virtual {v4, v5}, Landroid/content/res/Resources;->getBoolean(I)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 1440
    invoke-direct {p0, v0, p1}, Lcom/android/internal/telephony/ServiceStateTracker;->adaptCarrierNameToLocale(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 1441
    invoke-direct {p0, v0, p3}, Lcom/android/internal/telephony/ServiceStateTracker;->adaptCarrierNameToLocale(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p3

    .line 1444
    :cond_0
    iget v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mCurSubId:I

    if-ne v3, v4, :cond_1

    iget-boolean v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mCurShowPlmn:Z

    if-ne p2, v4, :cond_1

    iget-boolean v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mCurShowSpn:Z

    if-ne p4, v4, :cond_1

    iget-object v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mCurSpn:Ljava/lang/String;

    invoke-static {p3, v4}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v4

    if-eqz v4, :cond_1

    iget-object v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mCurPlmn:Ljava/lang/String;

    invoke-static {p1, v4}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_2

    .line 1450
    :cond_1
    const-string v4, "sendSpnStringsBroadcast: showPlmn=\'%b\' plmn=\'%s\' showSpn=\'%b\' spn=\'%s\' for sub %d"

    const/4 v5, 0x5

    new-array v5, v5, [Ljava/lang/Object;

    const/4 v6, 0x0

    invoke-static {p2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v7

    aput-object v7, v5, v6

    const/4 v6, 0x1

    aput-object p1, v5, v6

    const/4 v6, 0x2

    invoke-static {p4}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v7

    aput-object v7, v5, v6

    const/4 v6, 0x3

    aput-object p3, v5, v6

    const/4 v6, 0x4

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    aput-object v7, v5, v6

    invoke-static {v4, v5}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Lcom/android/internal/telephony/ServiceStateTracker;->log(Ljava/lang/String;)V

    .line 1454
    new-instance v1, Landroid/content/Intent;

    const-string v4, "android.provider.Telephony.SPN_STRINGS_UPDATED"

    invoke-direct {v1, v4}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 1455
    .local v1, "intent":Landroid/content/Intent;
    const/high16 v4, 0x20000000

    invoke-virtual {v1, v4}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 1456
    const-string v4, "showSpn"

    invoke-virtual {v1, v4, p4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    .line 1457
    const-string v4, "spn"

    invoke-virtual {v1, v4, p3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 1458
    const-string v4, "showPlmn"

    invoke-virtual {v1, v4, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    .line 1459
    const-string v4, "plmn"

    invoke-virtual {v1, v4, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 1460
    invoke-static {v1, v2, v3}, Landroid/telephony/SubscriptionManager;->putPhoneIdAndSubIdExtra(Landroid/content/Intent;II)V

    .line 1461
    iget-object v4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPhoneBase:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v4}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v4

    sget-object v5, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    invoke-virtual {v4, v1, v5}, Landroid/content/Context;->sendStickyBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    .line 1464
    .end local v1    # "intent":Landroid/content/Intent;
    :cond_2
    iput-boolean p4, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mCurShowSpn:Z

    .line 1465
    iput-boolean p2, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mCurShowPlmn:Z

    .line 1466
    iput-object p3, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mCurSpn:Ljava/lang/String;

    .line 1467
    iput-object p1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mCurPlmn:Ljava/lang/String;

    .line 1468
    iput v3, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mCurSubId:I

    .line 1469
    return-void
.end method

.method public abstract setImsRegistrationState(Z)V
.end method

.method protected abstract setPowerStateToDesired()V
.end method

.method public setRadioPower(Z)V
    .locals 0
    .param p1, "power"    # Z

    .prologue
    .line 511
    iput-boolean p1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mDesiredPowerState:Z

    .line 513
    invoke-virtual {p0}, Lcom/android/internal/telephony/ServiceStateTracker;->setPowerStateToDesired()V

    .line 514
    return-void
.end method

.method protected abstract setRoamingType(Landroid/telephony/ServiceState;)V
.end method

.method protected shouldFixTimeZoneNow(Lcom/android/internal/telephony/PhoneBase;Ljava/lang/String;Ljava/lang/String;Z)Z
    .locals 11
    .param p1, "phoneBase"    # Lcom/android/internal/telephony/PhoneBase;
    .param p2, "operatorNumeric"    # Ljava/lang/String;
    .param p3, "prevOperatorNumeric"    # Ljava/lang/String;
    .param p4, "needToFixTimeZone"    # Z

    .prologue
    const/4 v7, 0x1

    const/4 v8, 0x0

    .line 1141
    const/4 v9, 0x0

    const/4 v10, 0x3

    :try_start_0
    invoke-virtual {p2, v9, v10}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v9

    invoke-static {v9}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v4

    .line 1154
    .local v4, "mcc":I
    const/4 v9, 0x0

    const/4 v10, 0x3

    :try_start_1
    invoke-virtual {p3, v9, v10}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v9

    invoke-static {v9}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    move-result v5

    .line 1160
    .local v5, "prevMcc":I
    :goto_0
    const/4 v3, 0x0

    .line 1161
    .local v3, "iccCardExist":Z
    iget-object v9, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mUiccApplcation:Lcom/android/internal/telephony/uicc/UiccCardApplication;

    if-eqz v9, :cond_0

    .line 1162
    iget-object v9, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mUiccApplcation:Lcom/android/internal/telephony/uicc/UiccCardApplication;

    invoke-virtual {v9}, Lcom/android/internal/telephony/uicc/UiccCardApplication;->getState()Lcom/android/internal/telephony/uicc/IccCardApplicationStatus$AppState;

    move-result-object v9

    sget-object v10, Lcom/android/internal/telephony/uicc/IccCardApplicationStatus$AppState;->APPSTATE_UNKNOWN:Lcom/android/internal/telephony/uicc/IccCardApplicationStatus$AppState;

    if-eq v9, v10, :cond_3

    move v3, v7

    .line 1166
    :cond_0
    :goto_1
    if-eqz v3, :cond_1

    if-ne v4, v5, :cond_2

    :cond_1
    if-eqz p4, :cond_4

    :cond_2
    move v6, v7

    .line 1168
    .local v6, "retVal":Z
    :goto_2
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    .line 1169
    .local v0, "ctm":J
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "shouldFixTimeZoneNow: retVal="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v6}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " iccCardExist="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " operatorNumeric="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " mcc="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " prevOperatorNumeric="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " prevMcc="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " needToFixTimeZone="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " ltod="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-static {v0, v1}, Landroid/util/TimeUtils;->logTimeOfDay(J)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {p0, v7}, Lcom/android/internal/telephony/ServiceStateTracker;->log(Ljava/lang/String;)V

    .line 1176
    .end local v0    # "ctm":J
    .end local v3    # "iccCardExist":Z
    .end local v4    # "mcc":I
    .end local v5    # "prevMcc":I
    .end local v6    # "retVal":Z
    :goto_3
    return v6

    .line 1142
    :catch_0
    move-exception v2

    .line 1144
    .local v2, "e":Ljava/lang/Exception;
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "shouldFixTimeZoneNow: no mcc, operatorNumeric="

    invoke-virtual {v7, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v9, " retVal=false"

    invoke-virtual {v7, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {p0, v7}, Lcom/android/internal/telephony/ServiceStateTracker;->log(Ljava/lang/String;)V

    move v6, v8

    .line 1147
    goto :goto_3

    .line 1155
    .end local v2    # "e":Ljava/lang/Exception;
    .restart local v4    # "mcc":I
    :catch_1
    move-exception v2

    .line 1156
    .restart local v2    # "e":Ljava/lang/Exception;
    add-int/lit8 v5, v4, 0x1

    .restart local v5    # "prevMcc":I
    goto/16 :goto_0

    .end local v2    # "e":Ljava/lang/Exception;
    .restart local v3    # "iccCardExist":Z
    :cond_3
    move v3, v8

    .line 1162
    goto/16 :goto_1

    :cond_4
    move v6, v8

    .line 1166
    goto/16 :goto_2
.end method

.method public unregisterForDataConnectionAttached(Landroid/os/Handler;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;

    .prologue
    .line 663
    iget-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mAttachedRegistrants:Landroid/os/RegistrantList;

    invoke-virtual {v0, p1}, Landroid/os/RegistrantList;->remove(Landroid/os/Handler;)V

    .line 664
    return-void
.end method

.method public unregisterForDataConnectionDetached(Landroid/os/Handler;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;

    .prologue
    .line 681
    iget-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mDetachedRegistrants:Landroid/os/RegistrantList;

    invoke-virtual {v0, p1}, Landroid/os/RegistrantList;->remove(Landroid/os/Handler;)V

    .line 682
    return-void
.end method

.method public unregisterForDataRegStateOrRatChanged(Landroid/os/Handler;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;

    .prologue
    .line 699
    iget-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mDataRegStateOrRatChangedRegistrants:Landroid/os/RegistrantList;

    invoke-virtual {v0, p1}, Landroid/os/RegistrantList;->remove(Landroid/os/Handler;)V

    .line 700
    return-void
.end method

.method public unregisterForDataRoamingOff(Landroid/os/Handler;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;

    .prologue
    .line 492
    iget-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mDataRoamingOffRegistrants:Landroid/os/RegistrantList;

    invoke-virtual {v0, p1}, Landroid/os/RegistrantList;->remove(Landroid/os/Handler;)V

    .line 493
    return-void
.end method

.method public unregisterForDataRoamingOn(Landroid/os/Handler;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;

    .prologue
    .line 471
    iget-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mDataRoamingOnRegistrants:Landroid/os/RegistrantList;

    invoke-virtual {v0, p1}, Landroid/os/RegistrantList;->remove(Landroid/os/Handler;)V

    .line 472
    return-void
.end method

.method public unregisterForNetworkAttached(Landroid/os/Handler;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;

    .prologue
    .line 717
    iget-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mNetworkAttachedRegistrants:Landroid/os/RegistrantList;

    invoke-virtual {v0, p1}, Landroid/os/RegistrantList;->remove(Landroid/os/Handler;)V

    .line 718
    return-void
.end method

.method public unregisterForPsRestrictedDisabled(Landroid/os/Handler;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;

    .prologue
    .line 755
    iget-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPsRestrictDisabledRegistrants:Landroid/os/RegistrantList;

    invoke-virtual {v0, p1}, Landroid/os/RegistrantList;->remove(Landroid/os/Handler;)V

    .line 756
    return-void
.end method

.method public unregisterForPsRestrictedEnabled(Landroid/os/Handler;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;

    .prologue
    .line 736
    iget-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPsRestrictEnabledRegistrants:Landroid/os/RegistrantList;

    invoke-virtual {v0, p1}, Landroid/os/RegistrantList;->remove(Landroid/os/Handler;)V

    .line 737
    return-void
.end method

.method public unregisterForVoiceRoamingOff(Landroid/os/Handler;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;

    .prologue
    .line 450
    iget-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mVoiceRoamingOffRegistrants:Landroid/os/RegistrantList;

    invoke-virtual {v0, p1}, Landroid/os/RegistrantList;->remove(Landroid/os/Handler;)V

    .line 451
    return-void
.end method

.method public unregisterForVoiceRoamingOn(Landroid/os/Handler;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;

    .prologue
    .line 429
    iget-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mVoiceRoamingOnRegistrants:Landroid/os/RegistrantList;

    invoke-virtual {v0, p1}, Landroid/os/RegistrantList;->remove(Landroid/os/Handler;)V

    .line 430
    return-void
.end method

.method protected updateCarrierMccMncConfiguration(Ljava/lang/String;Ljava/lang/String;Landroid/content/Context;)V
    .locals 2
    .param p1, "newOp"    # Ljava/lang/String;
    .param p2, "oldOp"    # Ljava/lang/String;
    .param p3, "context"    # Landroid/content/Context;

    .prologue
    .line 1282
    if-nez p1, :cond_0

    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    if-eqz p1, :cond_2

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 1284
    :cond_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "update mccmnc="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " fromServiceState=true"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/ServiceStateTracker;->log(Ljava/lang/String;)V

    .line 1285
    const/4 v0, 0x1

    invoke-static {p3, p1, v0}, Lcom/android/internal/telephony/MccTable;->updateMccMncConfiguration(Landroid/content/Context;Ljava/lang/String;Z)V

    .line 1287
    :cond_2
    return-void
.end method

.method protected updatePhoneObject()V
    .locals 2

    .prologue
    .line 405
    iget-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPhoneBase:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v0}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x112009b

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getBoolean(I)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 407
    iget-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mPhoneBase:Lcom/android/internal/telephony/PhoneBase;

    iget-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v1}, Landroid/telephony/ServiceState;->getRilVoiceRadioTechnology()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/PhoneBase;->updatePhoneObject(I)V

    .line 409
    :cond_0
    return-void
.end method

.method protected abstract updateSpnDisplay()V
.end method

.method protected useDataRegStateForDataOnlyDevices()V
    .locals 2

    .prologue
    .line 394
    iget-boolean v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mVoiceCapable:Z

    if-nez v0, :cond_0

    .line 396
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "useDataRegStateForDataOnlyDevice: VoiceRegState="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mNewSS:Landroid/telephony/ServiceState;

    invoke-virtual {v1}, Landroid/telephony/ServiceState;->getVoiceRegState()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " DataRegState="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mNewSS:Landroid/telephony/ServiceState;

    invoke-virtual {v1}, Landroid/telephony/ServiceState;->getDataRegState()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/ServiceStateTracker;->log(Ljava/lang/String;)V

    .line 400
    iget-object v0, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mNewSS:Landroid/telephony/ServiceState;

    iget-object v1, p0, Lcom/android/internal/telephony/ServiceStateTracker;->mNewSS:Landroid/telephony/ServiceState;

    invoke-virtual {v1}, Landroid/telephony/ServiceState;->getDataRegState()I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/telephony/ServiceState;->setVoiceRegState(I)V

    .line 402
    :cond_0
    return-void
.end method
