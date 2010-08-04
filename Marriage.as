package
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.masks.*;
	import net.flashpunk.utils.*;
	
	import net.flashpunk.Sfx;
	
	public class Marriage extends Entity
	{
		public var husband: Person = null;
		public var wife: Person = null;
		public var children: Vector.<Person> = new Vector.<Person>();
		
		public var sameSex:Boolean; 
		
		public var age: Number = 0;
		
		public var nextBaby: Number = 4;
		
		public var piety:Number = 5;
		
		[Embed(source = 'assets/baby.mp3')] 
		private const BABY1:Class;
		[Embed(source = 'assets/baby2.mp3')] 
		private const BABY2:Class;
		[Embed(source = 'assets/baby3.mp3')] 
		private const BABY3:Class;
		
		public var baby: Array = [new Sfx(BABY1), new Sfx(BABY2), new Sfx(BABY3)];
		
		[Embed(source = 'assets/wedding.mp3')] 
		private const WEDDING:Class;
		public var wedding:Sfx = new Sfx(WEDDING);
		
		public function Marriage (a: Person, b: Person)
		{
			if (a.gender == "male")
			{
				husband = a;
				wife = b;
			}else
			{
				wife = a;
				husband = b;
			}
			if (a.gender == b.gender)
			{
				sameSex = true;
				piety = -35;
			}else
			{
				sameSex = false;
			}
			
			husband.marriage = this;
			wife.marriage = this;
			
			layer = -1;
			
			nextBaby = 2 + Math.random() * 2;
			
			wedding.play();
		}
		
		public override function update (): void
		{
			if (husband == null)
			{
				return
			}
			
			age += 0.002;
			nextBaby -= 0.002;
			
			if (nextBaby < 0) {
				if (Math.random() < 0.5) {
					nextBaby = 1.0 + Math.random() * 1.5;
				} else {
					nextBaby = 100000;
				}
				
				if (sameSex == false)
				{
					var child: Person = new Person();
				
					child.x = wife.x + Math.random() * 16 - 8;
					child.y = wife.y + Math.random() * 16 - 8;
				
					children.push(child);
				
					FP.world.add(child);
					var world:Level = FP.world as Level;
					world.piety += 0.02
					if (world.piety > 1)
					{
						world.piety = 1;
					}
					FP.choose(baby).play();
				}
			}
			
		}
		
		public function other(a:Person):Person
		{
			if (husband == a)
			{
				return wife;
			}
			return husband;
		}
		
		public override function render (): void
		{
			if (husband == null)
			{
				return
			}
			Draw.linePlus(husband.x, husband.y, wife.x, wife.y, 0x800000, 1.0, 3.0);
			
			var midx: Number = (husband.x + wife.x) * 0.5;
			var midy: Number = (husband.y + wife.y) * 0.5;
			
			for each (var child: Person in children) {
				if (child.alive)
				{
					Draw.linePlus(midx, midy, child.x, child.y, 0x000000);
				}
			}
		}
		
		public function end_marriage():void
		{
			husband.marriage = null;
			wife.marriage = null;
			husband = null;
			wife = null;
		}
	}
}
