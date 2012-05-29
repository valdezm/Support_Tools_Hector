import me.prettyprint.hector.api.Cluster;
import me.prettyprint.hector.api.factory.HFactory;


public class GreatTest {

	public static void main(String[] args) {
		try{
		Cluster myCluster = HFactory.getOrCreateCluster("Tutorial", "50.57.51.31:9160");
		System.out.println(myCluster.describeRing("Tutorial"));
		}catch(Exception e){e.printStackTrace();}

	}

}
