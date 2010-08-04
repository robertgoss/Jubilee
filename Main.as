package
{
	import net.flashpunk.*;
	
	[SWF(width = "640", height = "480", backgroundColor="#000000")]
	public class Main extends Engine
	{
		public function Main() 
		{
			super(640, 480, 60, true);
			FP.screen.color = 0x55AA55;
			FP.world = new Level();
		}
	}
}
