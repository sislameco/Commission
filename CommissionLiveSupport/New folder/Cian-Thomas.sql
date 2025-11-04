	
	select * from Users where id = 79
	select * from userroles where id in (60,61)

	select * from commission.LeadUserCommissionsResult where ShouldUserId = 79

	drop table #79User
	select fkleadId into #79User from commission.LeadUserCommissions where FkUserId = 79 and Id in (	select LeadUserCommissionId from commission.LeadUserCommissionsResult where ShouldUserId = 79)


	select * from Users where id = 79

	select distinct u.fkleadid,s.Name from #79User u
	inner join quotation.leads l on l.Id = u.FkLeadId
	inner join setup.SchemeType s on s.Id = l.FkSchemeTypeId

	select * from quotation.LeadAssignedUsers where fkleadid in (select fkleadid from #79User) and FkAssignedUserId = 79 and FkRoleId = 61


	select * from commission.CommissionItems where FkCommissionTypeId = 35 


-- Cian
select distinct 
l.Id LeadId, 
l.LeadRefNo, 
LEFT(l.SimplifiedEirCode, 3) SimplifiedEirCode,
format( l.createdDate, 'dd/MM/yyyy') createdDate,
st.Name,
stu.StructureName, 
t.Name CommissionType  from quotation.Leads l 
inner join [commission].[CommissionStructure] stu on stu.Id = l.FkCommissionStructureId
inner join setup.SchemeType st on st.Id = l.FkSchemeTypeId
inner join commission.LeadUserCommissions lu on lu.FkLeadId = l.Id
inner join [commission].CommissionItems i on i.id = lu.FkCommissionItemId
inner join [commission].[CommissionTypes] t on t.Id = i.FkCommissionTypeId
where LEFT(l.SimplifiedEirCode, 3) in ('H65 ','H53 ','H71 ','H54 ','H91 ','H62 ','N41 ','F26 ','F31 ','F35 ','F23 ','F12 ','F28 ','F52 ','F45 ','F42 ','F56 ','F91 ','F94 ','F92 ','F93')
and l.Id not in (	select FkLeadId from quotation.LeadAssignedUsers where fkleadid in (select fkleadid from #79User) and FkAssignedUserId = 79 and FkRoleId = 61)  
and t.id = 35 and i.Id in (54,55) and lu.FkUserId is null



select Id,leadrefno into #CianLead from quotation.Leads where leadrefno in ('CHS-224-3040-03',
'CHS-HEA-2945-09',
'CHS-HEU-10103-03',
'CHS-HEU-10556-01',
'CHS-HEU-10904-01',
'CHS-HEU-11000-00',
'CHS-HEU-8332-03',
'CHS-HEU-8734-02',
'CHS-HEU-9005-02',
'CHS-HEU-9370-01',
'CHS-HEU-9857-01',
'CHS-HEUO-10713-03',
'CHS-HEUP-10103-05',
'CHS-HEUP-10194-07',
'CHS-HEUP-10524-03',
'CHS-HEUP-10524-04',
'CHS-HEUP-10708-03',
'CHS-HEUP-11012-02',
'CHS-HEUP-11306-01',
'CHS-HEUP-11306-02',
'CHS-HEUP-11383-02',
'CHS-HEUP-11455-01',
'CHS-HEUP-11488-01',
'CHS-HEUP-11559-01',
'CHS-HEUP-11930-02',
'CHS-HEUP-11996-02',
'CHS-HEUP-12003-04',
'CHS-HEUP-12044-02',
'CHS-HEUP-12044-04',
'CHS-HEUP-12175-01',
'CHS-HEUP-12364-02',
'CHS-HEUP-12395-02',
'CHS-HEUP-12427-03',
'CHS-HEUP-12511-04',
'CHS-HEUP-12523-01',
'CHS-HEUP-12524-01',
'CHS-HEUP-12665-02',
'CHS-HEUP-12700-03',
'CHS-HEUP-12736-04',
'CHS-HEUP-12778-02',
'CHS-HEUP-12932-02',
'CHS-HEUP-12936-03',
'CHS-HEUP-12976-03',
'CHS-HEUP-13065-02',
'CHS-HEUP-13341-02',
'CHS-HEUP-13409-01',
'CHS-HEUP-3023-05',
'CHS-HEUP-3027-03',
'CHS-HEUP-3029-05',
'CHS-HEUP-3030-02',
'CHS-HEUP-3032-05',
'CHS-HEUP-3032-06',
'CHS-HEUP-3033-06',
'CHS-HEUP-3034-05',
'CHS-HEUP-3034-07',
'CHS-HEUP-3035-04',
'CHS-HEUP-3036-04',
'CHS-HEUP-3037-04',
'CHS-HEUP-3039-04',
'CHS-HEUP-3043-05',
'CHS-HEUP-3386-03',
'CHS-HEUP-9423-06',
'CHS-IEU-10393-02',
'CHS-IEU-10648-03',
'CHS-IEU-11589-03',
'CHS-IEU-11682-01',
'CHS-IEU-11682-03',
'CHS-IEU-12044-03',
'CHS-IEU-12972-01',
'CHS-IEU-13155-01',
'CHS-IEU-13171-02',
'CHS-IEU-13243-01',
'CHS-IEU-13409-02',
'CHS-IEU-13450-01',
'CHS-HEUP-10708-03')


select * from quotation.LeadAssignedUsers where FkLeadId in (select id from #CianLead) and FkAssignedUserId = 79 and fkroleId = 61



select * into #excludeFromAssignForCian from #CianLead where id not in (select FkLeadId from quotation.LeadAssignedUsers where FkLeadId in (select id from #CianLead) and FkAssignedUserId = 79 and fkroleId = 61)

select * from #excludeFromAssignForCian


select distinct 
l.Id LeadId, 
l.LeadRefNo, 
LEFT(l.SimplifiedEirCode, 3) SimplifiedEirCode,
format( l.createdDate, 'dd/MM/yyyy') createdDate,
st.Name,
stu.StructureName, 
t.Name CommissionType  from quotation.Leads l 
inner join [commission].[CommissionStructure] stu on stu.Id = l.FkCommissionStructureId
inner join setup.SchemeType st on st.Id = l.FkSchemeTypeId
inner join commission.LeadUserCommissions lu on lu.FkLeadId = l.Id
inner join [commission].CommissionItems i on i.id = lu.FkCommissionItemId
inner join [commission].[CommissionTypes] t on t.Id = i.FkCommissionTypeId
where l.id in (select Id from #CianLead) and  t.id = 35 and i.Id in (54,55) 

and lu.FkUserId is null


// 8866

update commission.LeadUserCommissions set  FkUserId = 79, UpdatedDate = getdate()   where FkLeadId in (select Id from #CianLead)
and FkUserId is null and FkCommissionItemId in  (54,55) 





DECLARE @LeadId INT;

DECLARE lead_cursor CURSOR FOR

 Select #excludeFromAssignForCian.Id from #excludeFromAssignForCian where Id not in (
  select FkLeadId from  quotation.LeadAssignedUsers where  FkAssignedUserId = 79 and fkroleid = 61 )

OPEN lead_cursor;
FETCH NEXT FROM lead_cursor INTO @LeadId;

WHILE @@FETCH_STATUS = 0
BEGIN
    INSERT INTO quotation.LeadAssignedUsers (
        FkLeadId,
        FkAssignedUserId,
        FkRoleId,
        CreatedBy,
        CreatedDate,
        RStatus
    )
    VALUES (
        @LeadId,
        79,       -- Project Manager
        61,       -- Role ID
        1,        -- CreatedBy (System Admin or Migration User)
        GETDATE(),
        1         -- Active
    );

    FETCH NEXT FROM lead_cursor INTO @LeadId;
END;

CLOSE lead_cursor;
DEALLOCATE lead_cursor;



























-- Thomas


	select fkleadId, FkCommissionItemId
	--into #1094User
	from commission.LeadUserCommissions where FkUserId = 1094 and Id in (	select LeadUserCommissionId from commission.LeadUserCommissionsResult where ShouldUserId = 1094)

	select distinct fkleadId from #1094User

	select * from quotation.LeadAssignedUsers where fkleadid in (select fkleadid from #1094User) and FkAssignedUserId = 1094 and FkRoleId = 61


select distinct 
l.Id LeadId, 
l.LeadRefNo, 
LEFT(l.SimplifiedEirCode, 3) SimplifiedEirCode,
format( l.createdDate, 'dd/MM/yyyy') createdDate,
st.Name,
stu.StructureName, 
t.Name CommissionType  from quotation.Leads l 
inner join [commission].[CommissionStructure] stu on stu.Id = l.FkCommissionStructureId
inner join setup.SchemeType st on st.Id = l.FkSchemeTypeId
inner join commission.LeadUserCommissions lu on lu.FkLeadId = l.Id
inner join [commission].CommissionItems i on i.id = lu.FkCommissionItemId
inner join [commission].[CommissionTypes] t on t.Id = i.FkCommissionTypeId
where LEFT(l.SimplifiedEirCode, 3) in ('R93','R21','K32','A41','A94','D01','D02','D03','D04','D05','D06','D6W','D07','D08','D09',
'D10','D11','D12','D13','D14','D15','D16','D17','D18','D20','D22','D24','A42','A96',
'K78','K45','K36','A45','K56','K34','K67','R14','R56','R51','W23','W34','W91','W12',
'R95','R32','A92','A91','A84','A86','A85','A83','A82','C15','A81','A75','H23','H18',
'R42','R35','R45','X35','X42','X91','Y21','Y25','Y34','Y35','Y14','A98','A63','A67','N37','N91','N39')
and l.Id not in (	select FkLeadId from quotation.LeadAssignedUsers where fkleadid in (select fkleadid from #1094User) and FkAssignedUserId = 1094 and FkRoleId = 61)  
and t.id = 35 and i.Id in (64,55) and lu.FkUserId is null






















