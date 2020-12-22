package chang_Byounggil;

public class Character {
	String name;
	int hp;
	int att;
	int def;
	
	//컨디션에 따른 캐릭터 스탯
	Character(String name, int condition){
		this.name = name;
		condition = condition <= 11 ? 11 : condition;
		this.hp = (int)(Math.random()*condition-10)+10;
		condition = condition <50 ? (int)(condition*1.2) : condition;
		this.att = (int)(Math.random()*(condition/2))+5;
		condition = condition <50 ? (int)(condition*0.8) : condition;
		this.def = (int)(Math.random()*(int)(condition/5))+5;
	}
	void showInfo(){
		System.out.println("==========================");
		System.out.println("********** 상태창 **********");
		System.out.println("==========================");
		System.out.println("이름  : "+this.name);
		System.out.println("HP  : "+this.hp);
		System.out.println("att  : "+this.att);
		System.out.println("def  : "+this.def);
	}
	
	void attack(Monster m){
		int damage = att - m.def;
		damage = damage <=0 ? 1 : damage;
		m.hp = m.hp < damage ? m.hp - m.hp : m.hp - damage;
		System.out.println(name + "가 공격으로 " + m.name + "에게 " 
				+ damage + "만큼 데미지를 주었습니다.");
		System.out.println(m.name + "의 남은 HP : " + m.hp);
	}
}
class Monster{
	String name;
	int hp;
	int att;
	int def;
	
	//컨디션에 따른 상태 주기
	Monster(int condition, String name){
		this.name = name;
		if(condition < 30){
			hp = 99;
			att = 99;
			def = 99;
		}else {
			hp = (int)(Math.random()*(50))+10;
			att = (int)(Math.random()*(15+1))+5;
			def = (int)(Math.random()*(15+1))+5;
		}
	}
	
	void attack(Character m){
		int damage = att - m.def;
		damage = damage <=0 ? 1 : damage;
		m.hp = m.hp < damage ? m.hp - m.hp : m.hp - damage;
		System.out.println(name + "가 공격으로" + m.name + "에게" 
							+ damage + "만큼 데미지를 주었습니다.");
		System.out.println(m.name + "의 남은 HP : " + m.hp);
	}
	
	
	
}
