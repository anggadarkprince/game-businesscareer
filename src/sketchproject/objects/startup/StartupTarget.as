package sketchproject.objects.startup
{
	import feathers.controls.TextArea;
	
	import sketchproject.core.Assets;
	import sketchproject.core.Data;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.HAlign;

	/**
	 * Update business plan and personal objective.
	 * 
	 * @author Angga
	 */
	public class StartupTarget extends Sprite
	{
		private var panel:Image;
		private var text:TextField;
		private var businessPlan:TextArea;
		private var personalObjective:TextArea;

		/**
		 * Default constructor of StartupTarget.
		 */
		public function StartupTarget()
		{
			super();
			initObjectProperty();
		}

		/**
		 * Initialize target component.
		 */
		public function initObjectProperty():void
		{
			text = new TextField(250, 50, "Personal Objective", Assets.getFont(Assets.FONT_CORegular).fontName, 25, 0xc0251e);
			text.x = 20;
			text.hAlign = HAlign.LEFT;
			addChild(text);

			text = new TextField(250, 50, "Business Plan", Assets.getFont(Assets.FONT_CORegular).fontName, 25, 0xc0251e);
			text.x = 530;
			text.hAlign = HAlign.LEFT;
			addChild(text);

			text = new TextField(350, 50, "Write your personal objective and target", Assets.getFont(Assets.FONT_CORegular).fontName, 14, 0x333333);
			text.x = 20;
			text.y = 25;
			text.hAlign = HAlign.LEFT;
			addChild(text);

			text = new TextField(350, 50, "Write best avhievement in your business career", Assets.getFont(Assets.FONT_CORegular).fontName, 14, 0x333333);
			text.x = 530;
			text.y = 25;
			text.hAlign = HAlign.LEFT;
			addChild(text);

			panel = new Image(Assets.getAtlas(Assets.DIALOG, Assets.DIALOG_XML).getTexture("small_panel"));
			panel.x = 20;
			panel.y = 80;
			panel.scaleX = 0.9;
			panel.scaleY = 0.9;
			addChild(panel);

			personalObjective = new TextArea();
			personalObjective.backgroundSkin = new Image(Assets.getAtlas(Assets.DIALOG, Assets.DIALOG).getTexture("small_panel"));
			personalObjective.backgroundFocusedSkin = new Image(Assets.getAtlas(Assets.DIALOG, Assets.DIALOG).getTexture("small_panel"));
			personalObjective.width = 323;
			personalObjective.height = 252;
			personalObjective.x = 30;
			personalObjective.y = 90;
			personalObjective.text = "Personal Profile...\n\nFinancial Target...\n\nStress...\n\nTime...\n\nBusiness...\n\nCareer..."
			personalObjective.selectRange(0, personalObjective.text.length);
			addChild(personalObjective);

			panel = new Image(Assets.getAtlas(Assets.DIALOG, Assets.DIALOG).getTexture("small_panel"));
			panel.x = 530;
			panel.y = 80;
			panel.scaleX = 0.9;
			panel.scaleY = 0.9;
			addChild(panel);

			businessPlan = new TextArea();
			personalObjective.backgroundSkin = new Image(Assets.getAtlas(Assets.DIALOG, Assets.DIALOG).getTexture("small_panel"));
			personalObjective.backgroundFocusedSkin = new Image(Assets.getAtlas(Assets.DIALOG, Assets.DIALOG).getTexture("small_panel"));
			businessPlan.width = 323;
			businessPlan.height = 252;
			businessPlan.x = 540;
			businessPlan.y = 90;
			businessPlan.text = "Executive summary...\n\nThe Opportunity...\n\nThe Product...\n\nThe Company...\n\nFinancial Projection...\n\nPromotion..."
			businessPlan.selectRange(0, businessPlan.text.length);
			addChild(businessPlan);
		}

		/**
		 * Update player's data by input 
		 */
		public function update():void
		{
			Data.businessPlan = businessPlan.text;
			Data.personalObjective = personalObjective.text;
		}
	}
}
