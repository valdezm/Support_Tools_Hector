import me.prettyprint.hector.api.Cluster;
import me.prettyprint.hector.api.factory.HFactory;


public class HectorRunner {

	public static void main(String[] args) {
		try{
		final String SERVER = args[0];
		final String CLUSTER = args[1];
		final String COMMAND = args[2];

		Cluster myCluster = HFactory.getOrCreateCluster(CLUSTER, SERVER);
		if(COMMAND.equals("status"))
		{	
			
			System.out.println(myCluster.describeRing(CLUSTER));
		}
		}catch(Exception e){e.printStackTrace();}

	}

}
