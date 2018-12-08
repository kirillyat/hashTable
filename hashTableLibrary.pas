unit hashTableLibrary;

interface

const
		{Размер ХЭШ-таблицы} {МОЖНО МЕНЯТЬ}
		n = 5;
	
type
		{Указатель на элемент таблицы}
		link = ^htElem;
		
		{Тип элементов} {МОЖНО МЕНЯТЬ}
		valueType = integer;
		
		{элементы ХЭШ-таблицы}
		htElem = record 
			value: valueType;
			next: link;
		end;
		
		{ХЭШ-таблица}
		hashTable = array[0..n - 1] of link;
		
		
		
		{Инициализация ХЭШ-Таблицы}
		procedure htInit(var ht: hashTable);
		
		{Добавление одного элемента}						
		procedure htAdd(var ht: hashTable; A: valueType);
		
		{Заполнение таблицы (несколько элементов)}
		procedure htFill(var ht: hashTable);
		
		{Удаляет элемент А}
		procedure htDelOne(var ht: hashTable; A: valueType);
		
		{Находится ли A в таблице?}
		function inHashTable(var ht: hashTable; A: valueType): boolean;
		
		{Дать ссылку на A}
		function findElement(var ht: hashTable; A: valueType): link;
		
		{Очистка таблицы и Освобождение памяти}
		procedure htFree(var ht: hashTable);
		
		{Сколько элементов в хэш таблице?}
		function htPower(var ht: hashTable): integer;
		
		{Вывод всех элементов}
		procedure htOutput(var ht: hashTable);
		
		
		
		
	
implementation


	{Инициализация ХЭШ-Таблицы}
procedure htInit(var ht: hashTable);
	var
		i: integer;
	begin
		for i := 0 to n - 1 do
			ht[i] := nil
	end;

	{Локальная процедура для очистки памяти (не идет в интерфейс)}
procedure Free(L: link);
	begin
		if L <> nil then begin
			if L^.next = nil then dispose(L)
			else Free(L^.next);
		end;
	end;
	
	
	
	{Очистка таблицы и Освобождение памяти}
procedure htFree(var ht: hashTable);
	var
		i: integer;
	begin
		for i := 0 to n - 1 do begin
			Free(ht[i]);
		end; 
		htInit(ht);
	end;
	

	{Добавление одного элемента}	
procedure htAdd(var ht: hashTable; A: valueType);
	var
	l, J: link;
	t:integer;
		
	begin
		t := a mod n;
		l := ht[A mod n];
		if ht[t] = nil then begin
				new(ht[t]);
				ht[t]^.value := A;
				ht[t]^.next := nil;
				
		end
		
		else begin
			while true do begin
				if  l^.next = nil then begin
					new(l^.next);
					l^.next^.value := A;
					l^.next^.next := nil;
					break;
				end
				else begin
					if l^.value >= A then begin
						new(J);
						J^.value := l^.value;
						J^.next := l^.next;
						l^.value := A;
						l^.next := J;
						break;
					end
					else l := l^.next;
				end;
			end;	
		end;
	end;
	

	{Заполнение таблицы (несколько элементов)}
procedure htFill(var ht: hashTable);
	var
 		A: valueType;
	begin
		while not eoln do begin
			read(A);
			htAdd(ht, A);
		end;
	end;
	
	
	{Локальная процедура для вывода (не идет в интерфейс)}
procedure outputLine(L: link);
	begin
		if L <> nil then begin
			write(' ', L^.value);
			outputLine(L^.next);
		end;
	end;
	

	{Вывод всех элементов}	
procedure htOutput(var ht: hashTable);
	var i : integer;
	begin
		writeln('Output of Hash Table');
		writeln('Size of Hash Table is :   ', n);
		for i:=0 to n-1 do begin
			write('[', i, ']');
			outputLine(ht[i]);
			writeln;
		end; 
	end;	
	
	
	{Находится ли A в таблице?}	
function inHashTable(var ht: hashTable; A: valueType): boolean;
	var
		l: link;
		f: boolean;
	begin
		l := ht[a mod n];
		f := False;
		while l <> nil do begin
			if l^.value = A then begin
				f := True;
				break;
			end
			else if l^.value > A then break
		end;
		inHashTable := f;
	end;
	
	{Дать ссылку на A}
function findElement(var ht: hashTable; A: valueType): link;
	var
		 l, result: link;
	begin
		l := ht[a mod n];
		result := nil;
		while l <> nil do begin
			if l^.value = A then begin
				result := l;
				break;
			end
			else if l^.value > A then break
		end;
		findElement := result;		
	end;
	
	
	{Удаляет элемент А из ХТ}
procedure htDelOne(var ht: hashtable; A: ValueType);
	var
		L, p: Link;
	begin
		L := ht[A mod n];
		while L <> nil do begin
			if L^.value = A then begin
				new(p);
				p := L;
				L := L^.next;
				dispose(p);
				break;
			end;
			L := L^.next;
		end;
	  
	end;


	{Показывает количество элементов в Хэш-таблице}
function htPower(var HT: hashtable): integer;
	var
		L: Link;
		count, k: integer;
	begin
		K := 0;
		count := 0;
		while (k < n) do begin     {Запускаем цикл,который проходит по каждой ячейке ХТ}
			L := ht[k mod n];
			k := k + 1;
			while L <> nil do begin {Запускаем цикл,который проходит "вглубь" каждой ячейки и подсчитываем их количество}
				count := count + 1;
				L := L^.next;
			end;
		end;
		htPower := count;
	end;





end.


