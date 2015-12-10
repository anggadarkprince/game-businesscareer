package sketchproject.core
{
	import flash.display.Bitmap;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.text.Font;
	import flash.utils.Dictionary;
	
	import sketchproject.objects.dialog.OptionDialog;
	
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Assets
	{
		// constant variable ---------------------------------------------------------------------------
		public static var ADDITIONAL:String = "TextureAdditional";
		public static var ADDITIONAL_XML:String = "XMLAdditional";
				
		public static var HELP:String = "TextureHelp";
		public static var HELP_XML:String = "XMLHelp";
				
		public static var CHARACTER:String = "TextureCharacter";
		public static var CHARACTER_XML:String = "XMLCharacter";
		
		public static var CONTENT:String = "TextureContent";
		public static var CONTENT_XML:String = "XMLContent";
		
		public static var DIALOG:String = "TextureDialog";
		public static var DIALOG_XML:String = "XMLDialog";
		
		public static var PANEL:String = "TexturePanel";
		public static var PANEL_XML:String = "XMLPanel";
		
		public static var BACKGROUND:String = "TextureBackground";
		public static var BACKGROUND_XML:String = "XMLBackground";
		
		public static var ISOMERTIC:String = "TextureIsometric";
		public static var ISOMERTIC_XML:String = "XMLIsometric";
		
		public static var NPC:String = "TextureNpc";
		public static var NPC_XML:String = "XMLNpc";
		
		
		public static var FONT_SSBOLD:String = "FontSSPBold";
		public static var FONT_SSREGULAR:String = "FontSSPRegular";
		public static var FONT_CORegular:String = "FontCarterOne";
		public static var FONT_ITCERAS:String = "FontErasITC";
		public static var FONT_DMIERAS:String = "FontErasDemi";
		
		// graphics assets -----------------------------------------------------------------------------	
		[Embed(source="../../../assets/graphics/world.png")]
		private static var GameWorld:Class;
		
		
		// help
		[Embed(source="../../../assets/graphics/HelpAtlas.png")]
		public static const TextureHelp:Class;		
		[Embed(source="../../../assets/graphics/HelpAtlas.xml", mimeType="application/octet-stream")]
		public static const XMLHelp:Class;
				
		// isometric
		[Embed(source="../../../assets/graphics/IsometricAtlas.png")]
		public static const TextureIsometric:Class;		
		[Embed(source="../../../assets/graphics/IsometricAtlas.xml", mimeType="application/octet-stream")]
		public static const XMLIsometric:Class;
		
		// npc
		[Embed(source="../../../assets/graphics/NpcAtlas.png")]
		public static const TextureNpc:Class;		
		[Embed(source="../../../assets/graphics/NpcAtlas.xml", mimeType="application/octet-stream")]
		public static const XMLNpc:Class;
		
		// character
		[Embed(source="../../../assets/graphics/CharacterAtlas.png")]
		public static const TextureCharacter:Class;		
		[Embed(source="../../../assets/graphics/CharacterAtlas.xml", mimeType="application/octet-stream")]
		public static const XMLCharacter:Class;
				
		// content
		[Embed(source="../../../assets/graphics/ContentAtlas.png")]
		public static const TextureContent:Class;		
		[Embed(source="../../../assets/graphics/ContentAtlas.xml", mimeType="application/octet-stream")]
		public static const XMLContent:Class;
		
		// dialog
		[Embed(source="../../../assets/graphics/DialogAtlas.png")]
		public static const TextureDialog:Class;		
		[Embed(source="../../../assets/graphics/DialogAtlas.xml", mimeType="application/octet-stream")]
		public static const XMLDialog:Class;
		
		// panel
		[Embed(source="../../../assets/graphics/PanelAtlas.png")]
		public static const TexturePanel:Class;		
		[Embed(source="../../../assets/graphics/PanelAtlas.xml", mimeType="application/octet-stream")]
		public static const XMLPanel:Class;
		
		// background
		[Embed(source="../../../assets/graphics/BackgroundAtlas.png")]
		public static const TextureBackground:Class;		
		[Embed(source="../../../assets/graphics/BackgroundAtlas.xml", mimeType="application/octet-stream")]
		public static const XMLBackground:Class;
		
		// background
		[Embed(source="../../../assets/graphics/AdditionalAtlas.png")]
		public static const TextureAdditional:Class;		
		[Embed(source="../../../assets/graphics/AdditionalAtlas.xml", mimeType="application/octet-stream")]
		public static const XMLAdditional:Class;
		
		
		
		// particle assets -----------------------------------------------------------------------------
		// fireworks
		[Embed(source="../../../assets/particles/fireworks.png")]
		private static var ParticleFireworks:Class;		
		[Embed(source="../../../assets/particles/fireworks.pex", mimeType="application/octet-stream")]
		public static var ParticleFireworksXML:Class;
		
		
		
		// font assets ---------------------------------------------------------------------------------
			
		[Embed(source="../../../assets/fonts/ArialBitmap.png")]
		public static const FontArialBitmap:Class;		
		[Embed(source="../../../assets/fonts/ArialBitmap.fnt", mimeType="application/octet-stream")]
		public static const XMLArialBitmap:Class;
		
		[Embed(source='../../../assets/fonts/SourceSansPro-Regular.ttf', embedAsCFF='false',fontName='SourceSansProRegular')]		
		public static var FontSSPRegular:Class;
		
		[Embed(source='../../../assets/fonts/SourceSansPro-Bold.ttf', embedAsCFF='false',fontName='SourceSansProBold')]		
		public static var FontSSPBold:Class;
		
		[Embed(source='../../../assets/fonts/ErasITC-Bold.ttf', embedAsCFF='false',fontName='ErasITCBold')]		
		public static var FontErasITC:Class;
		
		[Embed(source='../../../assets/fonts/ErasDemi.ttf', embedAsCFF='false',fontName='ErasDemi')]		
		public static var FontErasDemi:Class;
		
		[Embed(source='../../../assets/fonts/CarterOne.ttf', embedAsCFF='false',fontName='CarterOne')]		
		public static var FontCarterOne:Class;
		
		
		// sound assets --------------------------------------------------------------------------------
		// sound bgm
		[Embed(source="../../../assets/sounds/bgm/Title.mp3")]
		private static var bgmTitleSound:Class;
		[Embed(source="../../../assets/sounds/bgm/Festival.mp3")]
		private static var bgmFestivalSound:Class;
		[Embed(source="../../../assets/sounds/bgm/Summer.mp3")]
		private static var bgmSummerSound:Class;
		[Embed(source="../../../assets/sounds/bgm/Fall.mp3")]
		private static var bgmFallSound:Class;
		[Embed(source="../../../assets/sounds/bgm/Town.mp3")]
		private static var bgmTownSound:Class;
		
		public static var bgm:Sound;
		
		// sound sfx
		[Embed(source="../../../assets/sounds/sfx/Click.mp3")]
		private static var sfxClickSound:Class;
		public static var sfxClick:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/Coin.mp3")]
		private static var sfxCoinSound:Class;
		public static var sfxCoin:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/Harp.mp3")]
		private static var sfxHarpSound:Class;
		public static var sfxHarp:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/Strings.mp3")]
		private static var sfxStringsSound:Class;
		public static var sfxStrings:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/Switch.mp3")]
		private static var sfxSwitchSound:Class;
		public static var sfxSwitch:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/Fireworks.mp3")]
		private static var sfxFireworksSound:Class;
		public static var sfxFireworks:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/Boy Says Yes.mp3")]
		private static var sfxGirlSaysYesSound:Class;
		public static var sfxGirlSaysYes:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/Boy Says Oh No.mp3")]
		private static var sfxBoySaysOhNoSound:Class;
		public static var sfxBoySaysOhNo:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/Boy Says Yes.mp3")]
		private static var sfxBoySaysYesSound:Class;
		public static var sfxBoySaysYes:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/Boy Says Yippie.mp3")]
		private static var sfxBoySaysYippieSound:Class;
		public static var sfxBoySaysYippie:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/Girl Says Oh No.mp3")]
		private static var sfxGirlSaysOhNoSound:Class;
		public static var sfxGirlSaysOhNo:Sound;
		
		
		
		[Embed(source="../../../assets/sounds/sfx/Boy Says Yippie.mp3")]
		private static var sfxGirlSaysYippieSound:Class;
		public static var sfxGirlSaysYippie:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/City Crickets.mp3")]
		private static var sfxCityCricketsSound:Class;
		public static var sfxCityCrickets:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/City Daylight.mp3")]
		private static var sfxCityDaylightSound:Class;
		public static var sfxCityDaylight:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/Rain.mp3")]
		private static var sfxRainSound:Class;
		public static var sfxRain:Sound;

		
		
		[Embed(source="../../../assets/sounds/sfx/female/gameworld.mp3")]
		private static var sfxGameWorldSound:Class;
		public static var sfxGameWorld:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/female/business.mp3")]
		private static var sfxBusinessSound:Class;
		public static var sfxBusiness:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/female/product.mp3")]
		private static var sfxProductSound:Class;
		public static var sfxProduct:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/female/employee.mp3")]
		private static var sfxEmployeeSound:Class;
		public static var sfxEmployee:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/female/issues.mp3")]
		private static var sfxIssuesSound:Class;
		public static var sfxIssues:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/female/advertising.mp3")]
		private static var sfxAdvertisingSound:Class;
		public static var sfxAdvertising:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/female/finance.mp3")]
		private static var sfxFinanceSound:Class;
		public static var sfxFinance:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/female/customer.mp3")]
		private static var sfxCustomerSound:Class;
		public static var sfxCustomer:Sound;

		[Embed(source="../../../assets/sounds/sfx/female/tasklist.mp3")]
		private static var sfxTaskListSound:Class;
		public static var sfxTaskList:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/female/achievement.mp3")]
		private static var sfxAchievementSound:Class;
		public static var sfxAchievement:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/female/profit.mp3")]
		private static var sfxProfitSound:Class;
		public static var sfxProfit:Sound;
		
		
		[Embed(source="../../../assets/sounds/sfx/female/letsplay.mp3")]
		private static var sfxLetsPlaySound:Class;
		public static var sfxLetsPlay:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/female/exit.mp3")]
		private static var sfxExitSound:Class;
		public static var sfxExit:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/female/help.mp3")]
		private static var sfxHelpSound:Class;
		public static var sfxHelp:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/female/option.mp3")]
		private static var sfxOptionSound:Class;
		public static var sfxOption:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/female/businessprofile.mp3")]
		private static var sfxBusinessProfileSound:Class;
		public static var sfxBusinessProfile:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/female/gameparameter.mp3")]
		private static var sfxGameParameterSound:Class;
		public static var sfxGameParameter:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/female/objective.mp3")]
		private static var sfxObjectiveSound:Class;
		public static var sfxObjective:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/female/seedfinancing.mp3")]
		private static var sfxSeedFinancingSound:Class;
		public static var sfxSeedFinancing:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/female/avatar.mp3")]
		private static var sfxAvatarSound:Class;
		public static var sfxAvatar:Sound;
		
		
		[Embed(source="../../../assets/sounds/sfx/female/gamebooster.mp3")]
		private static var sfxGameBoosterSound:Class;
		public static var sfxGameBooster:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/female/leaderboard.mp3")]
		private static var sfxLeaderboardSound:Class;
		public static var sfxLeaderboard:Sound;
		
		
		[Embed(source="../../../assets/sounds/sfx/female/bgmactive.mp3")]
		private static var sfxBgmActiveSound:Class;
		public static var sfxBgmActive:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/female/bgmmute.mp3")]
		private static var sfxBgmMuteSound:Class;
		public static var sfxBgmMute:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/female/sfxactive.mp3")]
		private static var sfxSfxActiveSound:Class;
		public static var sfxSfxActive:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/female/sfxmute.mp3")]
		private static var sfxSfxMuteSound:Class;
		public static var sfxSfxMute:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/female/welcome.mp3")]
		private static var sfxWelcomeSound:Class;
		public static var sfxWelcome:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/female/pause.mp3")]
		private static var sfxPauseSound:Class;
		public static var sfxPause:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/female/backtomenu.mp3")]
		private static var sfxBackToMenuSound:Class;
		public static var sfxBackToMenu:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/female/logout.mp3")]
		private static var sfxLogoutSound:Class;
		public static var sfxLogout:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/female/shopoverview.mp3")]
		private static var sfxShopOverviewSound:Class;
		public static var sfxShopOverview:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/female/businessoperation.mp3")]
		private static var sfxBusinessOperationSound:Class;
		public static var sfxBusinessOperation:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/female/businessstartup.mp3")]
		private static var sfxBusinessStartupSound:Class;
		public static var sfxBusinessStartup:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/female/homestatistic.mp3")]
		private static var sfxHomeStatisticSound:Class;
		public static var sfxHomeStatistic:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/female/resumeslist.mp3")]
		private static var sfxResumesListSound:Class;
		public static var sfxResumesList:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/female/employeelist.mp3")]
		private static var sfxEmployeeListSound:Class;
		public static var sfxEmployeeList:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/female/employeeprogram.mp3")]
		private static var sfxEmployeeProgramSound:Class;
		public static var sfxEmployeeProgram:Sound;
		
		
		[Embed(source="../../../assets/sounds/sfx/female/productlist.mp3")]
		private static var sfxProductListSound:Class;
		public static var sfxProductList:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/female/inventory.mp3")]
		private static var sfxInventorySound:Class;
		public static var sfxInventory:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/female/supplier.mp3")]
		private static var sfxSupplierSound:Class;
		public static var sfxSupplier:Sound;
		
		
		[Embed(source="../../../assets/sounds/sfx/female/advertisement.mp3")]
		private static var sfxAdvertisementSound:Class;
		public static var sfxAdvertisement:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/female/researchpromotion.mp3")]
		private static var sfxResearchPromotionSound:Class;
		public static var sfxResearchPromotion:Sound;
		
		
		public static var bgmTransform:SoundTransform = new SoundTransform();
		public static var sfxTransform:SoundTransform = new SoundTransform();
		
		public static var bgmChannel:SoundChannel = new SoundChannel();
		public static var sfxChannel:SoundChannel = new SoundChannel();
				
		public static var BGM_TITLE:String = "title";
		public static var BGM_FESTIVAL:String = "festival";
		public static var BGM_SUMMER:String = "summer";
		public static var BGM_FALL:String = "fall";
		public static var BGM_TOWN:String = "town";
		
		// assets loader -------------------------------------------------------------------------------
		private static var gameTexture:Dictionary = new Dictionary();
		private static var gameTextureAtlas:Dictionary = new Dictionary();
		private static var gameVectorFont:Dictionary = new Dictionary();
				
		public static function getAtlas(name:String, map:String):TextureAtlas
		{
			if(gameTextureAtlas[name] == undefined)
			{
				var texture:Texture = getTexture(name);
				var xml:XML = new XML(new Assets[map]());
				gameTextureAtlas[name] = new TextureAtlas(texture, xml);
			}
			return gameTextureAtlas[name];
		}
				
		public static function getTexture(name:String):Texture
		{
			if(gameTexture[name] == undefined)
			{
				var bitmap:Bitmap = new Assets[name]();
				gameTexture[name] = Texture.fromBitmap(bitmap);
			}
			return gameTexture[name];
		}
		
		public static function getFont(name:String):Font
		{
			if(gameVectorFont[name] == undefined)
			{
				var font:Font = new Assets[name]();
				gameVectorFont[name] = font;
			}
			return gameVectorFont[name];
		}
		
		
		public static function init():void
		{			
			TextField.registerBitmapFont(new BitmapFont(Texture.fromBitmap(new FontArialBitmap()),XML(new XMLArialBitmap())));
			
			sfxClick = new sfxClickSound();
			sfxCoin = new sfxCoinSound();
			sfxHarp = new sfxHarpSound();
			sfxStrings = new sfxStringsSound();
			sfxSwitch = new sfxSwitchSound();
			sfxFireworks = new sfxFireworksSound();
			
			sfxGirlSaysYes = new sfxGirlSaysYesSound();
			
			sfxBoySaysOhNo = new sfxBoySaysOhNoSound();
			sfxBoySaysYes = new sfxBoySaysYesSound();
			sfxBoySaysYippie = new sfxBoySaysYippieSound();
			sfxGirlSaysOhNo = new sfxGirlSaysOhNoSound();
			
			sfxGirlSaysYippie = new sfxGirlSaysYippieSound();
			sfxCityCrickets = new sfxCityCricketsSound();
			sfxCityDaylight = new sfxCityDaylightSound();
			sfxRain = new sfxRainSound();
			
			sfxGameWorld = new sfxGameWorldSound();
			sfxBusiness = new sfxBusinessSound();
			sfxProduct = new sfxProductSound();
			sfxEmployee = new sfxEmployeeSound();
			sfxIssues = new sfxIssuesSound();
			sfxAdvertising = new sfxAdvertisingSound();
			sfxFinance = new sfxFinanceSound();
			
			sfxCustomer = new sfxCustomerSound();
			sfxTaskList = new sfxTaskListSound();
			sfxAchievement = new sfxAchievementSound();
			sfxProfit = new sfxProfitSound();
			
			sfxLetsPlay = new sfxLetsPlaySound();
			sfxExit = new sfxExitSound();
			sfxHelp = new sfxHelpSound();
			sfxOption = new sfxOptionSound();
			
			sfxBusinessProfile = new sfxBusinessProfileSound();
			sfxGameParameter = new sfxGameParameterSound();
			sfxObjective = new sfxObjectiveSound();
			sfxSeedFinancing = new sfxSeedFinancingSound();
			
			sfxAvatar = new sfxAvatarSound();			
			sfxLeaderboard = new sfxLeaderboardSound();
			sfxGameBooster = new sfxGameBoosterSound();
			
			sfxBgmActive = new sfxBgmActiveSound();
			sfxBgmMute = new sfxBgmMuteSound();			
			sfxSfxActive = new sfxSfxActiveSound();
			sfxSfxMute = new sfxSfxMuteSound();
			
			sfxPause = new sfxPauseSound();
			sfxWelcome = new sfxWelcomeSound();			
			sfxBackToMenu = new sfxBackToMenuSound();
			sfxLogout = new sfxLogoutSound();
			
			sfxShopOverview = new sfxShopOverviewSound();
			sfxBusinessOperation = new sfxBusinessOperationSound();
			sfxBusinessStartup = new sfxBusinessStartupSound();
			sfxHomeStatistic = new sfxHomeStatisticSound();
			
			sfxProductList = new sfxProductListSound();
			sfxInventory = new sfxInventorySound();
			sfxSupplier = new sfxSupplierSound();
			
			sfxResumesList = new sfxResumesListSound();
			sfxEmployeeList = new sfxEmployeeListSound();
			sfxEmployeeProgram = new sfxEmployeeProgramSound();
			
			sfxAdvertisement = new sfxAdvertisementSound();
			sfxResearchPromotion = new sfxResearchPromotionSound();
			
			OptionDialog.volumeBgm = Config.volbgm;
			OptionDialog.volumeSfx = Config.volsfx;
			
			setupGameSound();			
		}
		
		public static function setupGameSound():void
		{			
			bgmTransform.volume = OptionDialog.volumeBgm/10;
			sfxTransform.volume = OptionDialog.volumeSfx/10;
						
			bgmChannel.soundTransform = bgmTransform;
			sfxChannel.soundTransform = sfxTransform;
		}
		
		public static function playBgm(type:String):void
		{
			if(type == Assets.BGM_TITLE)
			{
				bgm = new bgmTitleSound();
			}
			
			if(type == Assets.BGM_FESTIVAL)
			{
				bgm = new bgmFestivalSound();
			}
			if(type == Assets.BGM_SUMMER)
			{
				bgm = new bgmSummerSound();
			}
			if(type == Assets.BGM_FALL)
			{
				bgm = new bgmFallSound();
			}
			if(type == Assets.BGM_TOWN)
			{
				bgm = new bgmTownSound();
			}
			
			Assets.bgmChannel.stop();
			Assets.bgmChannel = Assets.bgm.play(0,int.MAX_VALUE, bgmTransform);
			Assets.setupGameSound();
		}
		
	}
}