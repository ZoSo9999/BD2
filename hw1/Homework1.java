package simpledb.record;

import java.util.Random;

import simpledb.buffer.ReplacementStrategy;
import simpledb.server.SimpleDB;
import simpledb.tx.Transaction;

public class Homework1 {
	private Schema schR;
	private Schema schS;
	private Transaction tx; 
	private SimpleDB db;
	private Layout layoutR;
	private Layout layoutS;
	private TableScan tsR;
	private TableScan tsS;
	
	public void homework() {
		schR = new Schema();
		schR.addIntField("A");
		schR.addStringField("B", 15);
		layoutR = new Layout(schR);
		
		schS = new Schema();
		schS.addIntField("C");
		schS.addIntField("D");
		schS.addIntField("E");
		layoutS = new Layout(schS);
		
		for (String fldname : layoutR.schema().fields()) {
			int offset = layoutR.offset(fldname);
			System.out.println(fldname+" has offset "+offset);
		}
		System.out.println("RL of table R="+layoutR.slotSize());
		
		for (String fldname : layoutS.schema().fields()) {
			int offset = layoutS.offset(fldname);
			System.out.println(fldname+" has offset "+offset);
		}
		System.out.println("RL of table S="+layoutS.slotSize()+"\n");
		
		
		db.fileMgr().getBlockStats().reset();
		
		int leftLimit = 97; // letter 'a'
		int rightLimit = 122; // letter 'z'
   	 	int targetStringLength = 15;
   	 	Random random = new Random();
		tsR = new TableScan(tx, "R", layoutR);
		for (int i=1; i<=100000;  i++) {
			tsR.insert();
			tsR.setInt("A", i);
			String generatedString = random.ints(leftLimit, rightLimit + 1)
	   	    	      .limit(targetStringLength)
	   	    	      .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
	   	    	      .toString();
			tsR.setString("B", generatedString);
		}
		System.out.println("Inserimento 100.000 record in R:");
		db.fileMgr().getBlockStats().print();
		System.out.println();
		
		db.fileMgr().getBlockStats().reset();
				
		tsS = new TableScan(tx, "S", layoutS);		
		for (int i=1; i<=80000; i++) {
			tsS.insert();
			tsS.setInt("C", i%50);
			tsS.setInt("D", i);
			tsS.setInt("E", i%100);
		}
		System.out.println("Inserimento 80.000 record in S:");
		db.fileMgr().getBlockStats().print();
		System.out.println();
		
		db.fileMgr().getBlockStats().reset();	
		
		tsR.beforeFirst();
		int count=0;
		while (tsR.next() && tsR.getInt("A") <= 1000) {
			count++;
		}
		System.out.println("Ho letto "+count+" ennuple di R con 1<=A<=1000:");
		db.fileMgr().getBlockStats().print();
		System.out.println();
		
		db.fileMgr().getBlockStats().reset();
		
		
		tsR.beforeFirst();
		count=0;
		while (tsR.next() && tsR.getInt("A") <= 3000) {
			if (tsR.getInt("A") >= 2000 && tsR.getInt("A") <= 3000)
				count++;
		}
		System.out.println("Ho letto "+count+" ennuple di R con 2000<=A<=3000:");
		db.fileMgr().getBlockStats().print();
		System.out.println();
		
		db.fileMgr().getBlockStats().reset();
				
		
		tsR.beforeFirst();
		count=0;
		while (tsR.next() && tsR.getInt("A") <= 2600) {
			if (tsR.getInt("A") >= 2500 && tsR.getInt("A") <= 2600)
				count++;
		}
		System.out.println("Ho letto "+count+" ennuple di R con 2500<=A<=2600:");
		db.fileMgr().getBlockStats().print();
		System.out.println();
		
		db.fileMgr().getBlockStats().reset();
				
		tsS.beforeFirst();
		count=0;
		while (tsS.next() && tsS.getInt("D") <= 1000) {
			count++;
		}
		System.out.println("Ho letto "+count+" ennuple di S con 1<=D<=1000:");
		db.fileMgr().getBlockStats().print();
		System.out.println();
		
		db.fileMgr().getBlockStats().reset();
				

		tsS.beforeFirst();
		count=0;
		while(tsS.next()) {
			if(tsS.getInt("D")==tsS.getInt("E")) count++;
		}
		System.out.println("Le ennuple con D=E in S sono: "+count);
		db.fileMgr().getBlockStats().print();
		System.out.println();
		
		db.fileMgr().getBlockStats().reset();
	}
	

	private void naiveI() {
		db = new SimpleDB("Hw1Naive1", 100, 100);
	    tx = db.newTx();
	    db.bufferMgr().setRepStr(ReplacementStrategy.NAIVE);
	    this.homework();
	}
	
	private void naiveII() {
		db = new SimpleDB("Hw1naive2", 100, 1000);
	    tx = db.newTx();
	    db.bufferMgr().setRepStr(ReplacementStrategy.NAIVE);;
	    this.homework();
	}
	private void lruI() {
		db = new SimpleDB("Hw1LRU1", 1000, 250);
	    tx = db.newTx();
	    db.bufferMgr().setRepStr(ReplacementStrategy.LRU);
	    this.homework();
	}

	private void lruII() {
		db = new SimpleDB("Hw1Lru2", 500, 10000);
	    tx = db.newTx();
	    db.bufferMgr().setRepStr(ReplacementStrategy.LRU);
	    this.homework();
	}
	public static void main(String args[]) {
		 Homework1 hw = new Homework1();
//		 hw.naiveI();
//		 hw.naiveII();
//		 hw.lruI();
		 hw.lruII();
	 }
}
