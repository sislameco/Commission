

-- Thomas for already tagged 

select * from users where Id = 1094
select * from UserRoles where id = 61

60700/60700/

select FkLeadId,FkUserId into #tomasTaggedLead from commission.LeadUserCommissions where FkUserId = 1094 and FkCommissionItemId in (54,55) -- 60700
and FkUserId = 1094 -- 60700
--and id in (select LeadUserCommissionId from commission.LeadUserCommissionsResult) -- 38049

select distinct FkLeadId from #tomasTaggedLead

select * from quotation.LeadAssignedUsers where FkLeadId in (select distinct FkLeadId from #tomasTaggedLead) and FkAssignedUserId = 1094 and fkroleid = 61

select distinct * from #tomasTaggedLead

select distinct * from #tomasUnTaggedUserLead
--drop table #tomasTaggedLead
--drop table  #tomasUnTaggedUserLead



select distinct FkLeadId into #tomasUnTaggedUserLead from #tomasTaggedLead where fkleadid not in ( select FkLeadId from quotation.LeadAssignedUsers where FkAssignedUserId = 1094 and fkuserid = 1094)




 
DECLARE @LeadId INT;

DECLARE lead_cursor CURSOR FOR

 Select #tomasUnTaggedUserLead.FkLeadId from #tomasUnTaggedUserLead where #tomasUnTaggedUserLead.FkLeadId not in (
  select FkLeadId from  quotation.LeadAssignedUsers where  FkAssignedUserId = 1094 and fkroleid = 61 and rstatus = 1)

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
        1094,       -- Sales Director ID
        61,       -- Role ID
        1,        -- CreatedBy (System Admin or Migration User)
        GETDATE(),
        1         -- Active
    );

    FETCH NEXT FROM lead_cursor INTO @LeadId;
END;

CLOSE lead_cursor;
DEALLOCATE lead_cursor;







