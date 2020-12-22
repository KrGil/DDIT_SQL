package chang_Byounggil;

import e_oop.ScanUtil;

public class Condition_game {

	public static void main(String[] args) {
		new Condition_game().time();
	}
	
	void time(){
//		System.out.println((int)(30*1.2));
//		int a = -5;
//		System.out.println(Math.abs(a));
		Condition c = new Condition();
		int now_c =0;
		System.out.println("이름을 입력해 주세요");
		c.name = ScanUtil.nextLine();
		System.out.println();
		System.out.println("반갑습니다. "+c.name+"님. "+"그럼 게임을 시작하겠습니다.");
		System.out.println("==============================================================");
		System.out.println("현재 시간은 8시 20분. 나의 기분수치는 '"+70+"' 이다. "+"나의 행동을 선택하자");
		now_c = c.eight_twenty();
		System.out.println("==============================================================");
		System.out.println("현재 시간은 8시 50분. 나의 기분수치는 '"+now_c+"' 이다. "+"나의 행동을 선택하자");
		now_c = c.eight_fifty();
		System.out.println("==============================================================");
		System.out.println("현재 시간은 10시. 나의 기분수치는 '"+now_c+"' 이다. "+"나의 행동을 선택하자");
		now_c = c.ten();
		System.out.println("==============================================================");
		System.out.println("현재 시간은 18시. 나의 기분수치는 '"+now_c+"' 이다. "+"나의 행동을 선택하자");
		now_c = c.sixteen();
		System.out.println();
		System.out.println("나의 기분수치는 '"+now_c+"'");
		c.last();
		
	}
}
