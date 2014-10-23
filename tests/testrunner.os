﻿//////////////////////////////////////////////////////////////////
// 
// Объект-помощник для приемочного и юнит-тестирования
//
//////////////////////////////////////////////////////////////////

Перем Пути;
Перем КомандаЗапуска;
Перем НаборТестов;
Перем РезультатТестирования;

Перем НомерТестаДляЗапуска;
Перем НаименованиеТестаДляЗапуска;

Перем Рефлектор;

Перем ЗначенияСостоянияТестов;
Перем СтруктураПараметровЗапуска;


//////////////////////////////////////////////////////////////////////////////
// Программный интерфейс
//

//{ МЕТОДЫ ДЛЯ ПРОВЕРКИ ЗНАЧЕНИЙ (assertions). 

Процедура Проверить(Условие, ДопСообщениеОшибки = "") Экспорт
	Если Не Условие Тогда
		СообщениеОшибки = "Переданный параметр ("+Формат(Условие, "БЛ=ложь; БИ=истина")+") не является Истиной, а хотели, чтобы являлся." + ФорматДСО(ДопСообщениеОшибки);
		ВызватьИсключение(СообщениеОшибки);
	КонецЕсли;
КонецПроцедуры

Процедура ПроверитьИстину(Условие, ДопСообщениеОшибки = "") Экспорт
	Проверить(Условие, ДопСообщениеОшибки);
КонецПроцедуры

Процедура ПроверитьЛожь(Условие, ДопСообщениеОшибки = "") Экспорт
	Если Условие Тогда
		СообщениеОшибки = "Переданный параметр ("+Формат(Условие, "БЛ=ложь; БИ=истина")+") не является Ложью, а хотели, чтобы являлся." + ФорматДСО(ДопСообщениеОшибки);
		ВызватьИсключение(СообщениеОшибки);
	КонецЕсли;
КонецПроцедуры

Процедура ПроверитьДату(_Дата, _Период, ДопСообщениеОшибки = "") Экспорт
	Если _Дата < _Период.ДатаНачала или _Дата > _Период.ДатаОкончания Тогда
		представление = ПредставлениеПериода(_Период.ДатаНачала, _Период.ДатаОкончания, "ФП = Истина");
		СообщениеОшибки = "Переданный параметр ("+Формат(_Дата, "ДФ='dd.MM.yyyy HH:mm:ss'")+") не входит в период "+представление+", а хотели, чтобы являлся." + ФорматДСО(ДопСообщениеОшибки);
		ВызватьИсключение(СообщениеОшибки);
	КонецЕсли;
КонецПроцедуры

Процедура ПроверитьРавенство(ПервоеЗначение, ВтороеЗначение, ДопСообщениеОшибки = "") Экспорт
	Если ПервоеЗначение <> ВтороеЗначение Тогда
		СообщениеОшибки = "Сравниваемые значения ("+ПервоеЗначение+"; "+ВтороеЗначение+") не равны, а хотели, чтобы были равны." + ФорматДСО(ДопСообщениеОшибки);
		ВызватьИсключение(СообщениеОшибки);
	КонецЕсли;
КонецПроцедуры

Процедура ПроверитьНеРавенство(ПервоеЗначение, ВтороеЗначение, ДопСообщениеОшибки = "") Экспорт
	Если ПервоеЗначение = ВтороеЗначение Тогда
		СообщениеОшибки = "Сравниваемые значения ("+ПервоеЗначение+"; "+ВтороеЗначение+") равны, а хотели, чтобы были не равны." + ФорматДСО(ДопСообщениеОшибки);
		ВызватьИсключение(СообщениеОшибки);
	КонецЕсли;
КонецПроцедуры

Процедура ПроверитьБольше(_Больше, _Меньше, ДопСообщениеОшибки = "") Экспорт
	Если _Больше <= _Меньше Тогда
		СообщениеОшибки = "Первый параметр ("+_Больше+") меньше или равен второму ("+_Меньше+") а хотели, чтобы был больше." + ФорматДСО(ДопСообщениеОшибки);
		ВызватьИсключение(СообщениеОшибки);
	КонецЕсли;
КонецПроцедуры

Процедура ПроверитьБольшеИлиРавно(_Больше, _Меньше, ДопСообщениеОшибки = "") Экспорт
	Если _Больше < _Меньше Тогда
		СообщениеОшибки = "Первый параметр ("+_Больше+") меньше второго ("+_Меньше+") а хотели, чтобы был больше или равен." + ФорматДСО(ДопСообщениеОшибки);
		ВызватьИсключение(СообщениеОшибки);
	КонецЕсли;
КонецПроцедуры

Процедура ПроверитьМеньше(проверяемоеЗначение1, проверяемоеЗначение2, СообщениеОбОшибке = "") Экспорт
	Если проверяемоеЗначение1 >= проверяемоеЗначение2 Тогда
		ВызватьИсключение "Значение <"+проверяемоеЗначение1+"> больше или равно, чем <"+проверяемоеЗначение2+">, а ожидалось меньше"+
				ФорматДСО(СообщениеОбОшибке);
	КонецЕсли; 
КонецПроцедуры

Процедура ПроверитьМеньшеИлиРавно(проверяемоеЗначение1, проверяемоеЗначение2, СообщениеОбОшибке = "") Экспорт
	Если проверяемоеЗначение1 > проверяемоеЗначение2 Тогда
		ВызватьИсключение "Значение <"+проверяемоеЗначение1+"> больше, чем <"+проверяемоеЗначение2+">, а ожидалось меньше или равно"+
				ФорматДСО(СообщениеОбОшибке);
	КонецЕсли; 
КонецПроцедуры

// проверка идет через ЗначениеЗаполнено, но мутабельные значение всегда считаем заполненными
Процедура ПроверитьЗаполненность(ПроверяемоеЗначение, ДопСообщениеОшибки = "") Экспорт
    Попытка
        фЗаполнено = ЗначениеЗаполнено(ПроверяемоеЗначение);
    Исключение
        Возврат;
    КонецПопытки; 
    Если НЕ фЗаполнено Тогда
        ВызватьИсключение "Значение ("+ПроверяемоеЗначение+") не заполнено, а ожидалась заполненность" + ФорматДСО(ДопСообщениеОшибки);
    КонецЕсли; 
КонецПроцедуры

Процедура ПроверитьНеЗаполненность(ПроверяемоеЗначение, ДопСообщениеОшибки = "") Экспорт
	СообщениеОшибки = "Значение ("+ПроверяемоеЗначение+") заполнено, а ожидалась незаполненность" + ФорматДСО(ДопСообщениеОшибки);
	Попытка
        фЗаполнено = ЗначениеЗаполнено(ПроверяемоеЗначение);
    Исключение
        ВызватьИсключение СообщениеОшибки;
    КонецПопытки; 
    Если фЗаполнено Тогда
        ВызватьИсключение СообщениеОшибки;
    КонецЕсли; 
КонецПроцедуры

Процедура ПроверитьВхождение(строка, подстрокаПоиска, ДопСообщениеОшибки = "") Экспорт
	Если Найти(строка, подстрокаПоиска) = 0 Тогда
		СообщениеОшибки = "Искали в <"+строка+"> подстроку <"+подстрокаПоиска+">, но не нашли." + ФорматДСО(ДопСообщениеОшибки);
		ВызватьИсключение(СообщениеОшибки);
	КонецЕсли;
КонецПроцедуры

//}

//{ Выполнение тестов - экспортные методы для файла-запускателя start.os

Процедура ВыполнитьТесты(МассивПараметров) Экспорт
	Инициализация();
	РезультатТестирования = ЗначенияСостоянияТестов.НеВыполнялся;
	
	Если Не ОбработатьПараметрыЗапуска(МассивПараметров) Тогда
		РезультатТестирования = ЗначенияСостоянияТестов.НеВыполнялся;
	КонецЕсли; 
КонецПроцедуры 

Функция ПолучитьРезультатТестирования() Экспорт
	Возврат РезультатТестирования;
КонецФункции

//}

Функция ОбработатьПараметрыЗапуска(МассивПараметров)
	
	Если МассивПараметров.Количество() = 0 Тогда
		Возврат Ложь;
	КонецЕсли;
	НомерТестаДляЗапуска = Неопределено;
	НаименованиеТестаДляЗапуска = Неопределено;
	
	НомерПараметраПутьКТестам = -1;
	
	КомандаЗапуска = НРег(МассивПараметров[0]);
	Если КомандаЗапуска = СтруктураПараметровЗапуска.ПоказатьСписок Тогда
		путьКТестам = МассивПараметров[1];
	ИначеЕсли КомандаЗапуска = СтруктураПараметровЗапуска.Запустить Тогда
		НомерПараметраПутьКТестам = 1;
		
	Иначе
		КомандаЗапуска = СтруктураПараметровЗапуска.Запустить;
		НомерПараметраПутьКТестам = 0;
	КонецЕсли;

	Если КомандаЗапуска = СтруктураПараметровЗапуска.Запустить Тогда
		путьКТестам = МассивПараметров[НомерПараметраПутьКТестам];
		Если МассивПараметров.Количество() > НомерПараметраПутьКТестам+1 Тогда
			ИД_Теста = МассивПараметров[НомерПараметраПутьКТестам+1];
			
			Если ВСтрокеСодержатсяТолькоЦифры(ИД_Теста) Тогда
				НомерТестаДляЗапуска = Число(ИД_Теста);
			Иначе
				НаименованиеТестаДляЗапуска = ИД_Теста;
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
	Файл = Новый Файл(путьКТестам);
	Если Не Файл.Существует() Тогда
		ВызватьИсключение "Не найден файл/каталог "+путьКТестам;
	КонецЕсли;
	
	Пути.Добавить(ПутьКТестам);
	
	Если КомандаЗапуска = СтруктураПараметровЗапуска.ПоказатьСписок Тогда
		Сообщить("Список тестов:");
	КонецЕсли;

	ЗагрузитьТесты();

	Если КомандаЗапуска = СтруктураПараметровЗапуска.Запустить Тогда
		ВыполнитьВсеТесты();
	
		Сообщить(" ");

		Если КомандаЗапуска <> СтруктураПараметровЗапуска.ПоказатьСписок Тогда
			Если РезультатТестирования > ЗначенияСостоянияТестов.Прошел Тогда
				Сообщить("ОШИБКА: Есть непрошедшие тесты. Красная полоса");
			Иначе
				Сообщить("ОК. Зеленая полоса");
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
	Возврат Истина;
КонецФункции

Процедура СоздатьСтруктуруПараметровЗапуска()
	СтруктураПараметровЗапуска = Новый Структура;
	СтруктураПараметровЗапуска.Вставить("Запустить", НРег("-run"));
	СтруктураПараметровЗапуска.Вставить("ПоказатьСписок", НРег("-show"));
КонецПроцедуры

Процедура ЗагрузитьТесты()
	Перем НомерТестаСохр;
	
	Для Каждого ПутьТеста Из Пути Цикл
		Файл = Новый Файл(ПутьТеста);
		Если Файл.ЭтоКаталог() Тогда
			ВызватьИсключение "Пока не умею обрабатывать каталоги тестов";
		Иначе
			ПолноеИмяТестовогоСлучая = Файл.ПолноеИмя;
			ИмяКлассаТеста = Файл.ИмяБезРасширения+(Новый УникальныйИдентификатор);
			//Сообщить("ИмяКлассаТеста "+ИмяКлассаТеста);
			ПодключитьСценарий(Файл.ПолноеИмя, ИмяКлассаТеста);
			Тест = Новый(ИмяКлассаТеста);

			Если КомандаЗапуска = СтруктураПараметровЗапуска.ПоказатьСписок Тогда
				Сообщить("  Файл теста "+ПолноеИмяТестовогоСлучая);
			КонецЕсли;
			
			МассивТестовыхСлучаев = ПолучитьТестовыеСлучаи(Тест, ПолноеИмяТестовогоСлучая);
			Если МассивТестовыхСлучаев = Неопределено Тогда
				Продолжить;
			КонецЕсли;
			
			Для Каждого ТестовыйСлучай Из МассивТестовыхСлучаев Цикл
				// Если ТипЗнч(ТестовыйСлучай) = Тип("Строка") Тогда
				Если ЭтоСтрока(ТестовыйСлучай) Тогда
					ИмяТестовогоСлучая = ТестовыйСлучай;
					ПараметрыТеста = Неопределено;
					ПредставлениеТеста = ИмяТестовогоСлучая;
				Иначе
					ВызватьИсключение "Не умею обрабатывать описание тестового случая из ПолучитьСписокТестов, отличный от строки"; //TODO
						// ИмяТестовогоСлучая = ТестовыйСлучай.ИмяТеста;
						// параметрыТеста = ТестовыйСлучай;
						// Если НЕ ТестовыйСлучай.Свойство("ПредставлениеТеста", ПредставлениеТеста) или не ЗначениеЗаполнено(ПредставлениеТеста) Тогда
							// ПредставлениеТеста = ИмяТестовогоСлучая;
						// КонецЕсли;
				КонецЕсли;
				
				ОписаниеТеста = Новый Структура;
				ОписаниеТеста.Вставить("ТестОбъект", Тест);
				ОписаниеТеста.Вставить("ИмяКласса", ИмяКлассаТеста);
				ОписаниеТеста.Вставить("ПолноеИмя", ПолноеИмяТестовогоСлучая);
				ОписаниеТеста.Вставить("Параметры", ПараметрыТеста);
				ОписаниеТеста.Вставить("ИмяМетода", ИмяТестовогоСлучая);

				НаборТестов.Добавить(ОписаниеТеста);
				
				НомерТеста = НаборТестов.Количество()-1;
				Если КомандаЗапуска = СтруктураПараметровЗапуска.ПоказатьСписок Тогда
					Сообщить("    Имя теста <"+ИмяТестовогоСлучая+">, №теста <"+НомерТеста+">");

				ИначеЕсли КомандаЗапуска = СтруктураПараметровЗапуска.Запустить Тогда
					Если НаименованиеТестаДляЗапуска = Неопределено Тогда
						Если НомерТеста = НомерТестаДляЗапуска Тогда
							НомерТестаСохр = НомерТеста;
						КонецЕсли;
					Иначе
						Если НРег(НаименованиеТестаДляЗапуска) = НРег(ИмяТестовогоСлучая) Тогда
							НомерТестаСохр = НомерТеста;
						КонецЕсли;
					КонецЕсли;
				КонецЕсли;
			КонецЦикла;			
		КонецЕсли;
	КонецЦикла;
	
	Если НомерТестаСохр <> Неопределено Тогда
		ОписаниеТеста = НаборТестов[НомерТестаСохр];
		НаборТестов.Очистить();
		НаборТестов.Добавить(ОписаниеТеста);
	КонецЕсли;
КонецПроцедуры

Функция ВыполнитьВсеТесты()
	ПустойМассив = Новый Массив;
	Для Каждого ОписаниеТеста Из НаборТестов Цикл
		//Тест = Новый(ОписаниеТеста.ИмяКласса);
		Тест = ОписаниеТеста.ТестОбъект;
		ИмяМетода = ОписаниеТеста.ИмяМетода;
		
		Сообщить("    Запускаю тест "+ИмяМетода);
		Попытка
			Рефлектор.ВызватьМетод(Тест, ИмяМетода, ПустойМассив);
			
			РезультатТестирования = ЗапомнитьСамоеХудшееСостояние(РезультатТестирования, ЗначенияСостоянияТестов.Прошел);
			Если РезультатТестирования = ЗначенияСостоянияТестов.Прошел Тогда
				Сообщить("    Успешно");
			КонецЕсли;
		Исключение
			текстОшибки = ИнформацияОбОшибке().Описание;
			ВывестиСообщение("ОШИБКА выполнения теста <"+ИмяМетода+">, тест <"+ОписаниеТеста.ИмяКласса+">: "+текстОшибки);
			РезультатТестирования = ЗапомнитьСамоеХудшееСостояние(РезультатТестирования, ЗначенияСостоянияТестов.Сломался);
		КонецПопытки;
	КонецЦикла;
	
КонецФункции

Функция ПолучитьТестовыеСлучаи(ТестОбъект, ПолноеИмяОбъекта)

	Попытка
        
		МассивТестовыхСлучаев = ТестОбъект.ПолучитьСписокТестов(ЭтотОбъект);
		
	Исключение
		текстОшибки = ИнформацияОбОшибке().Описание; //ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()) ;
		
		// TODO если не использовать переменную ниже, а поставить вызов метода в условие, то будет глюк - внутрь условия не попадаем !
		ЕстьОшибка_МетодОбъектаНеОбнаружен = ЕстьОшибка_МетодОбъектаНеОбнаружен(текстОшибки, "ПолучитьСписокТестов");
		Если НЕ ЕстьОшибка_МетодОбъектаНеОбнаружен Тогда
		
			ВывестиОшибку("Набор тестов не загружен: " + ПолноеИмяОбъекта + "
			|	Ошибка получения списка тестовых случаев: " + ОписаниеОшибки());
			
			ТестОбъект = Неопределено;
		КонецЕсли;
		
		Возврат Неопределено;			
				
	КонецПопытки;

	// Если ТипЗнч(МассивТестовыхСлучаев) <> Тип("Массив") Тогда
	Если Строка(МассивТестовыхСлучаев) <> "Массив" Тогда
		
		ВывестиОшибку("Набор тестов не загружен: " + ПолноеИмяОбъекта + "
		|	Ошибка получения списка тестовых случаев: вместо массива имен тестовых случаев получен объект <" + Строка(МассивТестовыхСлучаев) + ">");
				// |	Ошибка получения списка тестовых случаев: вместо массива имен тестовых случаев получен объект <" + Строка(ТипЗнч(МассивТестовыхСлучаев)) + ">");
		ТестОбъект = Неопределено;
		Возврат Неопределено;			
		
	КонецЕсли;
	
	Если НЕ ПроверитьМассивТестовыхСлучаев(МассивТестовыхСлучаев, ТестОбъект, ПолноеИмяОбъекта) Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Возврат МассивТестовыхСлучаев;
		
КонецФункции

Функция ПроверитьМассивТестовыхСлучаев(МассивТестовыхСлучаев, ТестОбъект, ПолноеИмяОбъекта)
	Для каждого данныеТеста из МассивТестовыхСлучаев Цикл
		// Если ТипЗнч(данныеТеста) = Тип("Строка") Тогда
		Если ЭтоСтрока(данныеТеста) Тогда //Тип("Строка") Тогда
			Продолжить;
		КонецЕсли;
		
		// Если ТипЗнч(данныеТеста) <> Тип("Структура") Тогда
		Если Строка(данныеТеста) <> "Структура" Тогда
			ВывестиОшибку("Набор тестов не загружен: " + ПолноеИмяОбъекта + "
			|	Ошибка получения структуры описания тестового случая: " + ОписаниеОшибки());
			Возврат Ложь;
		КонецЕсли;
		Если НЕ данныеТеста.Свойство("ИмяТеста") Тогда
			ВывестиОшибку("Набор тестов не загружен: " + ПолноеИмяОбъекта + "
			|	Не задано имя теста в структуре описания тестового случая: " + ОписаниеОшибки());
			Возврат Ложь;
		КонецЕсли;
	КонецЦикла;
	Возврат Истина;
КонецФункции

Функция ЕстьОшибка_МетодОбъектаНеОбнаружен(текстОшибки, имяМетода)
	Результат = Ложь;
	Если Найти(текстОшибки, "Метод объекта не обнаружен ("+имяМетода+")") > 0 
		ИЛИ Найти(текстОшибки, "Object method not found ("+имяМетода+")") > 0  Тогда
		Результат = Истина;
	КонецЕсли;
	
	Возврат Результат;
КонецФункции

// Устанавливает новое текущее состояние выполнения тестов
// в соответствии с приоритетами состояний:
// 		Красное - заменяет все другие состояния
// 		Желтое - заменяет только зеленое состояние
// 		Зеленое - заменяет только серое состояние (тест не выполнялся ни разу).
Функция ЗапомнитьСамоеХудшееСостояние(ТекущееСостояние, НовоеСостояние)
	
	ТекущееСостояние = Макс(ТекущееСостояние, НовоеСостояние);
	Возврат ТекущееСостояние;
	
КонецФункции


Функция Макс(Значение1, Значение2)
	Если Значение1 > Значение2 Тогда
		Возврат Значение1;
	Иначе
		Возврат Значение2;
	КонецЕсли;
КонецФункции

Функция ЗначениеЗаполнено(Значение) Экспорт
	
	Если Значение = Неопределено Тогда
		Возврат Ложь;
	ИначеЕсли Значение = 0 Тогда
		Возврат Ложь;
	ИначеЕсли ПустаяСтрока(Значение) Тогда
		Возврат Ложь;
	Иначе
		Возврат Истина;
	КонецЕсли;
	
КонецФункции

Функция Формат(П1, П2, П3 = Неопределено)
	Возврат П1;
КонецФункции

Функция ПредставлениеПериода(ДатаНачала, ДатаОкончания, ФорматнаяСтрока = Неопределено)
	Возврат "с "+ДатаНачала+" по "+ДатаОкончания;
КонецФункции

Функция ЭтоСтрока(Значение)
	Возврат Строка(Значение) = Значение;
КонецФункции

Функция ФорматДСО(ДопСообщениеОшибки)
	Если ДопСообщениеОшибки = "" Тогда
		Возврат "";
	КонецЕсли;
	
	Возврат Символы.ПС + ДопСообщениеОшибки;
КонецФункции

Функция ВСтрокеСодержатсяТолькоЦифры(Знач ИсходнаяСтрока) Экспорт
	
	рез = Ложь;
	ДлинаСтроки = СтрДлина(ИсходнаяСтрока);
	Для Сч = 1 По ДлинаСтроки Цикл
		ТекущийСимвол = КодСимвола(Сред(ИсходнаяСтрока, Сч, 1));
		Если 48 <= ТекущийСимвол И ТекущийСимвол <= 57 Тогда
			рез = Истина;
		Иначе
			рез = Ложь;
		КонецЕсли;
	КонецЦикла;
	Возврат рез;	
КонецФункции

Процедура СоздатьСостояниеТестов()
	//{ Состояния тестов - ВАЖЕН порядок заполнения в мЗначенияСостоянияТестов, используется в ЗапомнитьСамоеХудшееСостояние
	ЗначенияСостоянияТестов = Новый Структура;
	ЗначенияСостоянияТестов.Вставить("НеВыполнялся", -1);
	ЗначенияСостоянияТестов.Вставить("Прошел"		, 0); // код 0 используется в командной строке для показа нормального завершения
	ЗначенияСостоянияТестов.Вставить("НеРеализован", 2);
	ЗначенияСостоянияТестов.Вставить("Сломался"	, 3);
	//} Состояния тестов
КонецПроцедуры

// Выводит сообщение. В тестах ВСЕГДА должна использоваться ВМЕСТО метода Сообщить().
// 
Функция ВывестиСообщение(ТекстСообщения) Экспорт	
	
	// Если ВыводЛогаВФорматеTeamCity Тогда
		// ТекстСообщения = СтрЗаменить(ТекстСообщения,"|","||");
		// ТекстСообщения = СтрЗаменить(ТекстСообщения,"'","|'");
		// ТекстСообщения = СтрЗаменить(ТекстСообщения,"[","|[");
		// ТекстСообщения = СтрЗаменить(ТекстСообщения,"]","|]");
		// ТекстСообщения = СтрЗаменить(ТекстСообщения,Символы.ВК,"|r");
		// ТекстСообщения = СтрЗаменить(ТекстСообщения,Символы.ПС,"|n");		
		
		// Сообщить("##teamcity[message text='"+ТекстСообщения+"' errorDetails='' status='"+мСоответствиеСтатусовДляTeamCity[Статус]+"']");
	// Иначе
		Сообщить(ТекстСообщения);
	// КонецЕсли;
	
КонецФункции

// Вызывает исключение с заданным текстом ошибки для прерывания выполнения тестового случая.
// 
Функция ПрерватьТест(ТекстОшибки) Экспорт
	
	ВызватьИсключение ТекстОшибки;
	
КонецФункции

Функция ВывестиОшибку(Ошибка) Экспорт
	
	НужныйТекстОшибки = Ошибка; //ПолучитьРазвернутыйТекстОшибки(Ошибка);
	
	ВывестиСообщение(НужныйТекстОшибки);

	Возврат НужныйТекстОшибки;
КонецФункции

Процедура Инициализация()
	Пути = Новый Массив;
	НаборТестов = Новый Массив;
	Рефлектор = Новый Рефлектор;

	СоздатьСостояниеТестов();
	СоздатьСтруктуруПараметровЗапуска();
	
	РезультатТестирования = ЗначенияСостоянияТестов.НеВыполнялся;
КонецПроцедуры
