package chang_Byounggil;

import chang_Byounggil.Dropship;
import chang_Byounggil.Marine;
import chang_Byounggil.Repairable;
import chang_Byounggil.SCV;
import chang_Byounggil.Starcraft_recruit;
import chang_Byounggil.Tank;
import chang_Byounggil.Unit;
import chang_Byounggil.terran;

public class Starcraft {
	public static void main(String[] args){
		Marine marine = new Marine();
		
		Tank tank = new Tank();
		Dropship dropship = new Dropship();
		SCV scv = new SCV();
		
		scv.repair(tank);
		scv.repair(dropship);
//		scv.repair(marine);
		Starcraft_recruit a = new Starcraft_recruit();
		a.recruit();
	}
}

class Money{
	int money;
	Money(){
		money = 200;
	}
}
class Unit{
	int hp; // 현재체력
	final int MAX_HP; //최대 체력
	String name;
	int cost;
	Unit(int hp){
		MAX_HP = hp;
		this.hp = MAX_HP;
	}
}
//super()가 자동으로 안된다(파라미터 때문에)!!!!
class Marine extends Unit implements terran{
	Marine() {
		super(40);
		name = "Marine";
		cost = 50;
	}
}

class Tank extends Unit implements Repairable, terran{
	Tank() {
		super(150);
		cost = 150;
	}
}

class Dropship extends Unit implements Repairable, terran{
	Dropship() {
		super(125);
		cost = 125;
	}
}

class SCV extends Unit{
	SCV(){
		super(60);
		cost = 50;
	}
	void repair(Repairable r){
		if(r instanceof Unit){ // Unit으로 형변환이 가능한지 확인
			Unit u = (Unit)r;
			while(u.hp < u.MAX_HP){
				u.hp++;
			}
		}
	}
}

interface Repairable{
	
}
interface terran{
	
}








