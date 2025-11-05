	


	select FkAssignedUserId,* from quotation.LeadAssignedUsers where FkLeadId not in (
	select FkLeadId from [commission].[LeadUserCommissions] 
	where id in (	select [LeadUserCommissionId] from  [commission].[LeadUserCommissionsResult]))

and FkAssignedUserId not in 
( select FkUserId from [commission].[LeadUserCommissions]
where id in (	select [LeadUserCommissionId] from  [commission].[LeadUserCommissionsResult]))



select FkUserId,FkLeadId into #Pats from [commission].[LeadUserCommissions]
where RStatus = 1 and id in (	select [LeadUserCommissionId] from  [commission].[LeadUserCommissionsResult] where ShouldUserId =  79) 
and FkUserId =  79


select p.FkLeadId,p.FkUserId, a.FkAssignedUserId , a.FkLeadId from #Pats p
left join quotation.LeadAssignedUsers a on p.FkLeadId = a.FkLeadId and p.FkUserId = FkAssignedUserId
where a.FkAssignedUserId = 79


select * from [commission].[CommissionItems] where [FkCommissionTypeId] = 31
drop table #patUntagged

select * from users where id in (79,1098,1094)


select distinct FkLeadId,le.LeadRefNo,l.CreatedDate leadCreatedDate, se.Name Scheme, st.StructureName Structure into #patUntagged from commission.LeadUserCommissions l
inner join [commission].[CommissionItems] i on l.FkCommissionItemId = i.Id
inner join quotation.Leads le on le.Id = l.FkLeadId
inner join commission.CommissionStructure st on st.id = le.FkCommissionStructureId 
inner join setup.SchemeType se on se.id = le.FkSchemeTypeId
where FkUserId is null and FkCommissionItemId in (select id from [commission].[CommissionItems] where [FkCommissionTypeId] = 31
)
select * from #patUntagged

select * from quotation.LeadAssignedUsers where FkLeadId in (
select FkLeadId from #patUntagged) and FkAssignedUserId = 79



select * from quotation.LeadAssignedUsers where FkLeadId in (
select FkLeadId from #patUntagged) and FkAssignedUserId = 1098


-- not in 

select * from 
select * from #patUntagged where FkLeadId not in (
select FkLeadId from quotation.LeadAssignedUsers where  FkAssignedUserId = 1098) 





