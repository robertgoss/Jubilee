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
		
		[Embed(source = 'assets/baby.mp3')] 
		private const POP:Class;
		public var pop:Sfx = new Sfx(POP);
		
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
			}else
			{
				sameSex = false;
			}
			
			husband.marriage = this;
			wife.marriage = this;
			
			layer = -1;
			
			nextBaby = 2 + Math.random() * 2;
		}
		
		public override function update (): void
		{
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
					pop.play()
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
			Draw.linePlus(husband.x, husband.y, wife.x, wife.y, 0xFF0000);
			
			var midx: Number = (husband.x + wife.x) * 0.5;
			var midy: Number = (husband.y + wife.y) * 0.5;
			
			for each (var child: Person in children) {
				Draw.linePlus(midx, midy, child.x, child.y, 0x000000);
			}
		}
	}
}
