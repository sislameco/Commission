
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
and l.Id not in (	select FkLeadId from quotation.LeadAssignedUsers where  FkAssignedUserId = 1094 and FkRoleId = 61)  
and t.id = 35 and i.Id in (54,55) and lu.FkUserId is null and lu.FkCommissionItemId in (54,55)