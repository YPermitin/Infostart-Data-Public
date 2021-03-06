﻿
&НаКлиенте
Процедура ЗаполнитьТовары(Команда)
	
	ЗаполнитьТоварыСервер();
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ЗаполнитьТоварыСервер()
	
	НомерГрупп = 10;
	НомерПодгруппы = 5;
	КоличествоТоваров = 20;
	
	Пока НомерГрупп <> 0 Цикл
		
		ИмяГруппы = "Группа - " + Формат(НомерГрупп, "ЧДЦ=0; ЧГ=0");
		
		Группа = СоздатьГруппу(ИмяГруппы);
		
		Пока НомерПодгруппы <> 0 Цикл
			
			ИмяПодгруппы = ИмяГруппы + " - " + Формат(НомерПодгруппы, "ЧДЦ=0; ЧГ=0");
			
			Подгруппа = СоздатьГруппу(ИмяПодгруппы, Группа);
			
			СоздатьТовары(Подгруппа, КоличествоТоваров);
			            			
			НомерПодгруппы = НомерПодгруппы - 1;
			
		КонецЦикла;
		
		НомерПодгруппы = 5;
		НомерГрупп = НомерГрупп - 1;
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция СоздатьГруппу(ИмяГруппы, Родитель = Неопределено)
	
	Группа = Справочники.Товары.НайтиПоНаименованию(ИмяГруппы, Истина);
	Если Группа.Пустая() Тогда
		Группа = Справочники.Товары.СоздатьГруппу();
		Группа.Наименование = ИмяГруппы;
		Группа.Родитель = Родитель;
		Группа.Записать();
		Возврат Группа.Ссылка;
	КонецЕсли;
	Возврат Группа;
	
КонецФункции

&НаСервереБезКонтекста
Процедура СоздатьТовары(Родитель, Знач КолТоваров)
	
	ИмяРодителя = СтрЗаменить(Родитель.Наименование, "Группа", "Элемент");
	
	Пока КолТоваров <> 0 Цикл
		
		ИмяТовара = ИмяРодителя + " - " + Формат(КолТоваров,"ЧДЦ=0; ЧГ=0");
		
		Товар = Справочники.Товары.НайтиПоНаименованию(ИмяТовара, Истина);
		Если НЕ Товар.Пустая() Тогда
			Продолжить;
		КонецЕсли;
		
		Товар = Справочники.Товары.СоздатьЭлемент();
		Товар.Наименование = ИмяТовара;
		Товар.Родитель = Родитель;
		Товар.Артикул = Строка(Новый УникальныйИдентификатор);
		Товар.Записать();
		
		КолТоваров = КолТоваров - 1;
		
	КонецЦикла;
	
КонецПроцедуры