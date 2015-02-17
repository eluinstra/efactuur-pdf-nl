<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <title>Validations for Invoice Mapping; strict=false</title>
  <ns prefix="oagis" uri="http://www.openapplications.org/oagis" />
  <ns prefix="hrxml" uri="http://ns.hr-xml.org/2007-04-15" />
  <pattern id="prohibitions">
    <rule context="oagis:Invoice/oagis:Header">
      <assert test="empty(oagis:TaxWithholdingExempt)">oagis:Invoice/oagis:Header may not contain oagis:TaxWithholdingExempt</assert>
      <assert test="empty(oagis:SpecialPriceAuthorization)">oagis:Invoice/oagis:Header may not contain oagis:SpecialPriceAuthorization</assert>
      <assert test="empty(oagis:PromisedDeliveryDate)">oagis:Invoice/oagis:Header may not contain oagis:PromisedDeliveryDate</assert>
      <assert test="empty(oagis:Distribution)">oagis:Invoice/oagis:Header may not contain oagis:Distribution</assert>
      <assert test="empty(oagis:ExtendedPrice)">oagis:Invoice/oagis:Header may not contain oagis:ExtendedPrice</assert>
      <assert test="empty(oagis:Reason)">oagis:Invoice/oagis:Header may not contain oagis:Reason</assert>
      <assert test="empty(oagis:Allowance)">oagis:Invoice/oagis:Header may not contain oagis:Allowance</assert>
      <assert test="empty(oagis:OrderStatus)">oagis:Invoice/oagis:Header may not contain oagis:OrderStatus</assert>
      <assert test="empty(oagis:NeedDeliveryDate)">oagis:Invoice/oagis:Header may not contain oagis:NeedDeliveryDate</assert>
      <assert test="empty(oagis:Priority)">oagis:Invoice/oagis:Header may not contain oagis:Priority</assert>
      <assert test="empty(oagis:License)">oagis:Invoice/oagis:Header may not contain oagis:License</assert>
      <assert test="empty(oagis:FreightClass)">oagis:Invoice/oagis:Header may not contain oagis:FreightClass</assert>
      <assert test="empty(oagis:TotalAllowance)">oagis:Invoice/oagis:Header may not contain oagis:TotalAllowance</assert>
      <assert test="empty(oagis:LastModificationDateTime)">oagis:Invoice/oagis:Header may not contain oagis:LastModificationDateTime</assert>
      <assert test="empty(oagis:DropShipInd)">oagis:Invoice/oagis:Header may not contain oagis:DropShipInd</assert>
      <assert test="empty(oagis:ShipPriorToDueDateInd)">oagis:Invoice/oagis:Header may not contain oagis:ShipPriorToDueDateInd</assert>
      <assert test="empty(oagis:EarliestShipDate)">oagis:Invoice/oagis:Header may not contain oagis:EarliestShipDate</assert>
      <assert test="empty(oagis:PromisedShipDate)">oagis:Invoice/oagis:Header may not contain oagis:PromisedShipDate</assert>
      <assert test="empty(oagis:ShipNote)">oagis:Invoice/oagis:Header may not contain oagis:ShipNote</assert>
      <assert test="empty(oagis:BackOrderedInd)">oagis:Invoice/oagis:Header may not contain oagis:BackOrderedInd</assert>
      <assert test="empty(oagis:TransportationTerm)">oagis:Invoice/oagis:Header may not contain oagis:TransportationTerm</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Attachments">
      <assert test="empty(oagis:DrawingAttachment)">oagis:Invoice/oagis:Header/oagis:Attachments may not contain oagis:DrawingAttachment</assert>
      <assert test="empty(oagis:InstructionsAttachment)">oagis:Invoice/oagis:Header/oagis:Attachments may not contain oagis:InstructionsAttachment</assert>
      <assert test="empty(oagis:PictureAttachment)">oagis:Invoice/oagis:Header/oagis:Attachments may not contain oagis:PictureAttachment</assert>
      <assert test="empty(oagis:DataSheetAttachment)">oagis:Invoice/oagis:Header/oagis:Attachments may not contain oagis:DataSheetAttachment</assert>
      <assert test="empty(oagis:FileAttachment)">oagis:Invoice/oagis:Header/oagis:Attachments may not contain oagis:FileAttachment</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Attachments/oagis:Attachment">
      <assert test="empty(oagis:UserArea)">oagis:Invoice/oagis:Header/oagis:Attachments/oagis:Attachment may not contain oagis:UserArea</assert>
      <assert test="empty(oagis:FileSize)">oagis:Invoice/oagis:Header/oagis:Attachments/oagis:Attachment may not contain oagis:FileSize</assert>
      <assert test="empty(oagis:DocumentDate)">oagis:Invoice/oagis:Header/oagis:Attachments/oagis:Attachment may not contain oagis:DocumentDate</assert>
      <assert test="empty(oagis:URI)">oagis:Invoice/oagis:Header/oagis:Attachments/oagis:Attachment may not contain oagis:URI</assert>
      <assert test="empty(oagis:Title)">oagis:Invoice/oagis:Header/oagis:Attachments/oagis:Attachment may not contain oagis:Title</assert>
      <assert test="empty(oagis:FileName)">oagis:Invoice/oagis:Header/oagis:Attachments/oagis:Attachment may not contain oagis:FileName</assert>
      <assert test="empty(oagis:ISBN)">oagis:Invoice/oagis:Header/oagis:Attachments/oagis:Attachment may not contain oagis:ISBN</assert>
      <assert test="empty(@inline)">oagis:Invoice/oagis:Header/oagis:Attachments/oagis:Attachment may not contain @inline</assert>
      <assert test="empty(oagis:Note)">oagis:Invoice/oagis:Header/oagis:Attachments/oagis:Attachment may not contain oagis:Note</assert>
      <assert test="empty(oagis:Description)">oagis:Invoice/oagis:Header/oagis:Attachments/oagis:Attachment may not contain oagis:Description</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Charges">
      <assert test="empty(oagis:AdditionalCharge)">oagis:Invoice/oagis:Header/oagis:Charges may not contain oagis:AdditionalCharge</assert>
      <assert test="empty(oagis:SpecificAmountCharge)">oagis:Invoice/oagis:Header/oagis:Charges may not contain oagis:SpecificAmountCharge</assert>
      <assert test="empty(oagis:BasicFreightCharge)">oagis:Invoice/oagis:Header/oagis:Charges may not contain oagis:BasicFreightCharge</assert>
      <assert test="empty(oagis:OriginPortCharge)">oagis:Invoice/oagis:Header/oagis:Charges may not contain oagis:OriginPortCharge</assert>
      <assert test="empty(oagis:DestinationPortCharge)">oagis:Invoice/oagis:Header/oagis:Charges may not contain oagis:DestinationPortCharge</assert>
      <assert test="empty(oagis:DestinationHaulageCharge)">oagis:Invoice/oagis:Header/oagis:Charges may not contain oagis:DestinationHaulageCharge</assert>
      <assert test="empty(oagis:TransportToLocationCharge)">oagis:Invoice/oagis:Header/oagis:Charges may not contain oagis:TransportToLocationCharge</assert>
      <assert test="empty(oagis:AllCostsToLocationCharge)">oagis:Invoice/oagis:Header/oagis:Charges may not contain oagis:AllCostsToLocationCharge</assert>
      <assert test="empty(oagis:SupplementaryCharge)">oagis:Invoice/oagis:Header/oagis:Charges may not contain oagis:SupplementaryCharge</assert>
      <assert test="empty(oagis:TransportationCharge)">oagis:Invoice/oagis:Header/oagis:Charges may not contain oagis:TransportationCharge</assert>
      <assert test="empty(oagis:WeightValuationCharge)">oagis:Invoice/oagis:Header/oagis:Charges may not contain oagis:WeightValuationCharge</assert>
      <assert test="empty(oagis:TransportPlusAdditionalCharge)">oagis:Invoice/oagis:Header/oagis:Charges may not contain oagis:TransportPlusAdditionalCharge</assert>
      <assert test="empty(oagis:TotalCharge)">oagis:Invoice/oagis:Header/oagis:Charges may not contain oagis:TotalCharge</assert>
      <assert test="empty(oagis:AllCharge)">oagis:Invoice/oagis:Header/oagis:Charges may not contain oagis:AllCharge</assert>
      <assert test="empty(oagis:MiscellaneousCharge)">oagis:Invoice/oagis:Header/oagis:Charges may not contain oagis:MiscellaneousCharge</assert>
      <assert test="empty(oagis:DistribursmentCharge)">oagis:Invoice/oagis:Header/oagis:Charges may not contain oagis:DistribursmentCharge</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Charges/oagis:Charge">
      <assert test="empty(oagis:UserArea)">oagis:Invoice/oagis:Header/oagis:Charges/oagis:Charge may not contain oagis:UserArea</assert>
      <assert test="empty(oagis:Id)">oagis:Invoice/oagis:Header/oagis:Charges/oagis:Charge may not contain oagis:Id</assert>
      <assert test="empty(oagis:Distribution)">oagis:Invoice/oagis:Header/oagis:Charges/oagis:Charge may not contain oagis:Distribution</assert>
      <assert test="empty(oagis:Cost)">oagis:Invoice/oagis:Header/oagis:Charges/oagis:Charge may not contain oagis:Cost</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Charges/oagis:Charge/oagis:Description">
      <assert test="empty(@owner)">oagis:Invoice/oagis:Header/oagis:Charges/oagis:Charge/oagis:Description may not contain @owner</assert>
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Charges/oagis:Charge/oagis:Description may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Description">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Description may not contain @lang</assert>
      <assert test="empty(@owner)">oagis:Invoice/oagis:Header/oagis:Description may not contain @owner</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:DocumentIds">
      <assert test="empty(oagis:SupplierDocumentId)">oagis:Invoice/oagis:Header/oagis:DocumentIds may not contain oagis:SupplierDocumentId</assert>
      <assert test="empty(oagis:CustomerDocumentId)">oagis:Invoice/oagis:Header/oagis:DocumentIds may not contain oagis:CustomerDocumentId</assert>
      <assert test="empty(oagis:BrokerDocumentId)">oagis:Invoice/oagis:Header/oagis:DocumentIds may not contain oagis:BrokerDocumentId</assert>
      <assert test="empty(oagis:LogisticsProviderDocumentId)">oagis:Invoice/oagis:Header/oagis:DocumentIds may not contain oagis:LogisticsProviderDocumentId</assert>
      <assert test="empty(oagis:ShippersDocumentId)">oagis:Invoice/oagis:Header/oagis:DocumentIds may not contain oagis:ShippersDocumentId</assert>
      <assert test="empty(oagis:CarrierDocumentId)">oagis:Invoice/oagis:Header/oagis:DocumentIds may not contain oagis:CarrierDocumentId</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:DocumentIds/oagis:DocumentId">
      <assert test="empty(oagis:Revision)">oagis:Invoice/oagis:Header/oagis:DocumentIds/oagis:DocumentId may not contain oagis:Revision</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:DocumentReferences">
      <assert test="empty(oagis:ProjectReference)">oagis:Invoice/oagis:Header/oagis:DocumentReferences may not contain oagis:ProjectReference</assert>
      <assert test="empty(oagis:LedgerDocumentReference)">oagis:Invoice/oagis:Header/oagis:DocumentReferences may not contain oagis:LedgerDocumentReference</assert>
      <assert test="empty(oagis:QuoteDocumentReference)">oagis:Invoice/oagis:Header/oagis:DocumentReferences may not contain oagis:QuoteDocumentReference</assert>
      <assert test="empty(oagis:RFQDocumentReference)">oagis:Invoice/oagis:Header/oagis:DocumentReferences may not contain oagis:RFQDocumentReference</assert>
      <assert test="empty(oagis:UOMGroupReference)">oagis:Invoice/oagis:Header/oagis:DocumentReferences may not contain oagis:UOMGroupReference</assert>
      <assert test="empty(oagis:ContractDocumentReference)">oagis:Invoice/oagis:Header/oagis:DocumentReferences may not contain oagis:ContractDocumentReference</assert>
      <assert test="empty(oagis:ReceiptDocumentReference)">oagis:Invoice/oagis:Header/oagis:DocumentReferences may not contain oagis:ReceiptDocumentReference</assert>
      <assert test="empty(oagis:CatalogDocumentReference)">oagis:Invoice/oagis:Header/oagis:DocumentReferences may not contain oagis:CatalogDocumentReference</assert>
      <assert test="empty(oagis:VoucherDocumentReference)">oagis:Invoice/oagis:Header/oagis:DocumentReferences may not contain oagis:VoucherDocumentReference</assert>
      <assert test="empty(oagis:MaintenanceOrderReference)">oagis:Invoice/oagis:Header/oagis:DocumentReferences may not contain oagis:MaintenanceOrderReference</assert>
      <assert test="empty(oagis:SalesOrderDocumentReference)">oagis:Invoice/oagis:Header/oagis:DocumentReferences may not contain oagis:SalesOrderDocumentReference</assert>
      <assert test="empty(oagis:RequisitionDocumentReference)">oagis:Invoice/oagis:Header/oagis:DocumentReferences may not contain oagis:RequisitionDocumentReference</assert>
      <assert test="empty(oagis:PurchaseOrderDocumentReference)">oagis:Invoice/oagis:Header/oagis:DocumentReferences may not contain oagis:PurchaseOrderDocumentReference</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference">
      <assert test="empty(oagis:Name)">oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:Name</assert>
      <assert test="empty(oagis:Status)">oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:Status</assert>
      <assert test="empty(oagis:Description)">oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:Description</assert>
      <assert test="empty(oagis:UserArea)">oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:UserArea</assert>
      <assert test="empty(oagis:Usage)">oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:Usage</assert>
      <assert test="empty(oagis:Note)">oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:Note</assert>
      <assert test="empty(oagis:DocumentDate)">oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:DocumentDate</assert>
      <assert test="empty(oagis:LineNumber)">oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:LineNumber</assert>
      <assert test="empty(oagis:ScheduleLineNumber)">oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:ScheduleLineNumber</assert>
      <assert test="empty(oagis:SubLineNumber)">oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:SubLineNumber</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds">
      <assert test="empty(oagis:BrokerDocumentId)">oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds may not contain oagis:BrokerDocumentId</assert>
      <assert test="empty(oagis:ShippersDocumentId)">oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds may not contain oagis:ShippersDocumentId</assert>
      <assert test="empty(oagis:SupplierDocumentId)">oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds may not contain oagis:SupplierDocumentId</assert>
      <assert test="empty(oagis:CarrierDocumentId)">oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds may not contain oagis:CarrierDocumentId</assert>
      <assert test="empty(oagis:LogisticsProviderDocumentId)">oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds may not contain oagis:LogisticsProviderDocumentId</assert>
      <assert test="empty(oagis:CustomerDocumentId)">oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds may not contain oagis:CustomerDocumentId</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds/oagis:DocumentId">
      <assert test="empty(oagis:Revision)">oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds/oagis:DocumentId may not contain oagis:Revision</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Note">
      <assert test="empty(@entryDateTime)">oagis:Invoice/oagis:Header/oagis:Note may not contain @entryDateTime</assert>
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Note may not contain @lang</assert>
      <assert test="empty(@author)">oagis:Invoice/oagis:Header/oagis:Note may not contain @author</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties">
      <assert test="empty(oagis:ManufacturerParty)">oagis:Invoice/oagis:Header/oagis:Parties may not contain oagis:ManufacturerParty</assert>
      <assert test="empty(oagis:CarrierParty)">oagis:Invoice/oagis:Header/oagis:Parties may not contain oagis:CarrierParty</assert>
      <assert test="empty(oagis:BrokerParty)">oagis:Invoice/oagis:Header/oagis:Parties may not contain oagis:BrokerParty</assert>
      <assert test="empty(oagis:EmployeeParty)">oagis:Invoice/oagis:Header/oagis:Parties may not contain oagis:EmployeeParty</assert>
      <assert test="empty(oagis:FreightBillToParty)">oagis:Invoice/oagis:Header/oagis:Parties may not contain oagis:FreightBillToParty</assert>
      <assert test="empty(oagis:ShipFromParty)">oagis:Invoice/oagis:Header/oagis:Parties may not contain oagis:ShipFromParty</assert>
      <assert test="empty(oagis:ShipToParty)">oagis:Invoice/oagis:Header/oagis:Parties may not contain oagis:ShipToParty</assert>
      <assert test="empty(oagis:HoldAtParty)">oagis:Invoice/oagis:Header/oagis:Parties may not contain oagis:HoldAtParty</assert>
      <assert test="empty(oagis:ImporterParty)">oagis:Invoice/oagis:Header/oagis:Parties may not contain oagis:ImporterParty</assert>
      <assert test="empty(oagis:PayFromParty)">oagis:Invoice/oagis:Header/oagis:Parties may not contain oagis:PayFromParty</assert>
      <assert test="empty(oagis:ReturnToParty)">oagis:Invoice/oagis:Header/oagis:Parties may not contain oagis:ReturnToParty</assert>
      <assert test="empty(oagis:ExporterParty)">oagis:Invoice/oagis:Header/oagis:Parties may not contain oagis:ExporterParty</assert>
      <assert test="empty(oagis:PublisherParty)">oagis:Invoice/oagis:Header/oagis:Parties may not contain oagis:PublisherParty</assert>
      <assert test="empty(oagis:JointVentureParty)">oagis:Invoice/oagis:Header/oagis:Parties may not contain oagis:JointVentureParty</assert>
      <assert test="empty(oagis:SoldToParty)">oagis:Invoice/oagis:Header/oagis:Parties may not contain oagis:SoldToParty</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty">
      <assert test="empty(oagis:Currency)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty may not contain oagis:Currency</assert>
      <assert test="empty(oagis:Business)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty may not contain oagis:Business</assert>
      <assert test="empty(oagis:Attachments)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty may not contain oagis:Attachments</assert>
      <assert test="empty(oagis:AlternatePartyIds)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty may not contain oagis:AlternatePartyIds</assert>
      <assert test="empty(oagis:Rating)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty may not contain oagis:Rating</assert>
      <assert test="empty(@oneTime)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty may not contain @oneTime</assert>
      <assert test="empty(oagis:TermId)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty may not contain oagis:TermId</assert>
      <assert test="empty(oagis:Qualification)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty may not contain oagis:Qualification</assert>
      <assert test="empty(oagis:UserArea)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty may not contain oagis:UserArea</assert>
      <assert test="empty(oagis:GLEntity)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty may not contain oagis:GLEntity</assert>
      <assert test="empty(oagis:PaymentMethod)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty may not contain oagis:PaymentMethod</assert>
      <assert test="empty(oagis:CorrespondenceLanguage)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty may not contain oagis:CorrespondenceLanguage</assert>
      <assert test="empty(@active)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty may not contain @active</assert>
      <assert test="empty(oagis:TaxExemptInd)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty may not contain oagis:TaxExemptInd</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses">
      <assert test="empty(oagis:Address)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses may not contain oagis:Address</assert>
      <assert test="empty(oagis:SecondaryAddress)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses may not contain oagis:SecondaryAddress</assert>
      <assert test="empty(oagis:ShippingAddress)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses may not contain oagis:ShippingAddress</assert>
      <assert test="empty(oagis:DropShipAddress)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses may not contain oagis:DropShipAddress</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses/oagis:PrimaryAddress">
      <assert test="empty(oagis:TaxJurisdiction)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses/oagis:PrimaryAddress may not contain oagis:TaxJurisdiction</assert>
      <assert test="empty(oagis:UserArea)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses/oagis:PrimaryAddress may not contain oagis:UserArea</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses/oagis:PrimaryAddress/oagis:AddressId">
      <assert test="empty(@qualifyingAgency)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses/oagis:PrimaryAddress/oagis:AddressId may not contain @qualifyingAgency</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses/oagis:PrimaryAddress/oagis:Description">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses/oagis:PrimaryAddress/oagis:Description may not contain @lang</assert>
      <assert test="empty(@owner)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses/oagis:PrimaryAddress/oagis:Description may not contain @owner</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts">
      <assert test="empty(oagis:SecondaryContact)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts may not contain oagis:SecondaryContact</assert>
      <assert test="empty(oagis:Buyer)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts may not contain oagis:Buyer</assert>
      <assert test="empty(oagis:SalesPerson)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts may not contain oagis:SalesPerson</assert>
      <assert test="empty(oagis:ContactAbs)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts may not contain oagis:ContactAbs</assert>
      <assert test="empty(oagis:DeliverToContact)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts may not contain oagis:DeliverToContact</assert>
      <assert test="empty(oagis:Requester)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts may not contain oagis:Requester</assert>
      <assert test="empty(oagis:MarketingContact)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts may not contain oagis:MarketingContact</assert>
      <assert test="empty(oagis:PrimaryContact)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts may not contain oagis:PrimaryContact</assert>
      <assert test="empty(oagis:SalesContact)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts may not contain oagis:SalesContact</assert>
      <assert test="empty(oagis:Planner)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts may not contain oagis:Planner</assert>
      <assert test="empty(oagis:AccountingContact)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts may not contain oagis:AccountingContact</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact">
      <assert test="empty(oagis:UserArea)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact may not contain oagis:UserArea</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses">
      <assert test="empty(oagis:DropShipAddress)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses may not contain oagis:DropShipAddress</assert>
      <assert test="empty(oagis:SecondaryAddress)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses may not contain oagis:SecondaryAddress</assert>
      <assert test="empty(oagis:ShippingAddress)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses may not contain oagis:ShippingAddress</assert>
      <assert test="empty(oagis:Address)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses may not contain oagis:Address</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress">
      <assert test="empty(oagis:UserArea)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may not contain oagis:UserArea</assert>
      <assert test="empty(oagis:TaxJurisdiction)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may not contain oagis:TaxJurisdiction</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:AddressId">
      <assert test="empty(@qualifyingAgency)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:AddressId may not contain @qualifyingAgency</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:Description">
      <assert test="empty(@owner)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:Description may not contain @owner</assert>
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:Description may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Description">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Description may not contain @lang</assert>
      <assert test="empty(@owner)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Description may not contain @owner</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person">
      <assert test="empty(oagis:UserArea)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person may not contain oagis:UserArea</assert>
      <assert test="empty(oagis:PersonCode)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person may not contain oagis:PersonCode</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName">
      <assert test="empty(oagis:UserArea)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may not contain oagis:UserArea</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:FamilyName">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:FamilyName may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:FormattedName">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:FormattedName may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:GivenName">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:GivenName may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:MiddleName">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:MiddleName may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:PreferredGivenName">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:PreferredGivenName may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:Salutation">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:Salutation may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:Suffix">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:Suffix may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Description">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Description may not contain @lang</assert>
      <assert test="empty(@owner)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Description may not contain @owner</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Name">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Name may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:PartyId">
      <assert test="empty(oagis:DUNS)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:PartyId may not contain oagis:DUNS</assert>
      <assert test="empty(oagis:SCAC)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:PartyId may not contain oagis:SCAC</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty">
      <assert test="empty(oagis:Rating)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty may not contain oagis:Rating</assert>
      <assert test="empty(oagis:Currency)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty may not contain oagis:Currency</assert>
      <assert test="empty(oagis:CorrespondenceLanguage)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty may not contain oagis:CorrespondenceLanguage</assert>
      <assert test="empty(oagis:TaxExemptInd)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty may not contain oagis:TaxExemptInd</assert>
      <assert test="empty(oagis:TermId)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty may not contain oagis:TermId</assert>
      <assert test="empty(oagis:Qualification)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty may not contain oagis:Qualification</assert>
      <assert test="empty(oagis:Business)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty may not contain oagis:Business</assert>
      <assert test="empty(@active)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty may not contain @active</assert>
      <assert test="empty(@oneTime)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty may not contain @oneTime</assert>
      <assert test="empty(oagis:UserArea)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty may not contain oagis:UserArea</assert>
      <assert test="empty(oagis:GLEntity)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty may not contain oagis:GLEntity</assert>
      <assert test="empty(oagis:Attachments)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty may not contain oagis:Attachments</assert>
      <assert test="empty(oagis:PaymentMethod)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty may not contain oagis:PaymentMethod</assert>
      <assert test="empty(oagis:AlternatePartyIds)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty may not contain oagis:AlternatePartyIds</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses">
      <assert test="empty(oagis:Address)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses may not contain oagis:Address</assert>
      <assert test="empty(oagis:ShippingAddress)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses may not contain oagis:ShippingAddress</assert>
      <assert test="empty(oagis:DropShipAddress)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses may not contain oagis:DropShipAddress</assert>
      <assert test="empty(oagis:SecondaryAddress)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses may not contain oagis:SecondaryAddress</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses/oagis:PrimaryAddress">
      <assert test="empty(oagis:UserArea)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses/oagis:PrimaryAddress may not contain oagis:UserArea</assert>
      <assert test="empty(oagis:TaxJurisdiction)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses/oagis:PrimaryAddress may not contain oagis:TaxJurisdiction</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses/oagis:PrimaryAddress/oagis:AddressId">
      <assert test="empty(@qualifyingAgency)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses/oagis:PrimaryAddress/oagis:AddressId may not contain @qualifyingAgency</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses/oagis:PrimaryAddress/oagis:Description">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses/oagis:PrimaryAddress/oagis:Description may not contain @lang</assert>
      <assert test="empty(@owner)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses/oagis:PrimaryAddress/oagis:Description may not contain @owner</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts">
      <assert test="empty(oagis:Buyer)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts may not contain oagis:Buyer</assert>
      <assert test="empty(oagis:Planner)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts may not contain oagis:Planner</assert>
      <assert test="empty(oagis:SalesPerson)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts may not contain oagis:SalesPerson</assert>
      <assert test="empty(oagis:SalesContact)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts may not contain oagis:SalesContact</assert>
      <assert test="empty(oagis:SecondaryContact)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts may not contain oagis:SecondaryContact</assert>
      <assert test="empty(oagis:Requester)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts may not contain oagis:Requester</assert>
      <assert test="empty(oagis:DeliverToContact)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts may not contain oagis:DeliverToContact</assert>
      <assert test="empty(oagis:ContactAbs)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts may not contain oagis:ContactAbs</assert>
      <assert test="empty(oagis:AccountingContact)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts may not contain oagis:AccountingContact</assert>
      <assert test="empty(oagis:MarketingContact)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts may not contain oagis:MarketingContact</assert>
      <assert test="empty(oagis:PrimaryContact)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts may not contain oagis:PrimaryContact</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact">
      <assert test="empty(oagis:UserArea)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact may not contain oagis:UserArea</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses">
      <assert test="empty(oagis:DropShipAddress)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses may not contain oagis:DropShipAddress</assert>
      <assert test="empty(oagis:Address)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses may not contain oagis:Address</assert>
      <assert test="empty(oagis:SecondaryAddress)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses may not contain oagis:SecondaryAddress</assert>
      <assert test="empty(oagis:ShippingAddress)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses may not contain oagis:ShippingAddress</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress">
      <assert test="empty(oagis:TaxJurisdiction)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may not contain oagis:TaxJurisdiction</assert>
      <assert test="empty(oagis:UserArea)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may not contain oagis:UserArea</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:AddressId">
      <assert test="empty(@qualifyingAgency)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:AddressId may not contain @qualifyingAgency</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:Description">
      <assert test="empty(@owner)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:Description may not contain @owner</assert>
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:Description may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Description">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Description may not contain @lang</assert>
      <assert test="empty(@owner)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Description may not contain @owner</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person">
      <assert test="empty(oagis:PersonCode)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person may not contain oagis:PersonCode</assert>
      <assert test="empty(oagis:UserArea)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person may not contain oagis:UserArea</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName">
      <assert test="empty(oagis:UserArea)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may not contain oagis:UserArea</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:FamilyName">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:FamilyName may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:FormattedName">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:FormattedName may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:GivenName">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:GivenName may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:MiddleName">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:MiddleName may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:PreferredGivenName">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:PreferredGivenName may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:Salutation">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:Salutation may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:Suffix">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:Suffix may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Description">
      <assert test="empty(@owner)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Description may not contain @owner</assert>
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Description may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Name">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Name may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:PartyId">
      <assert test="empty(oagis:DUNS)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:PartyId may not contain oagis:DUNS</assert>
      <assert test="empty(oagis:SCAC)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:PartyId may not contain oagis:SCAC</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty">
      <assert test="empty(oagis:UserArea)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty may not contain oagis:UserArea</assert>
      <assert test="empty(oagis:Business)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty may not contain oagis:Business</assert>
      <assert test="empty(@oneTime)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty may not contain @oneTime</assert>
      <assert test="empty(oagis:TermId)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty may not contain oagis:TermId</assert>
      <assert test="empty(oagis:GLEntity)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty may not contain oagis:GLEntity</assert>
      <assert test="empty(oagis:CorrespondenceLanguage)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty may not contain oagis:CorrespondenceLanguage</assert>
      <assert test="empty(oagis:Attachments)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty may not contain oagis:Attachments</assert>
      <assert test="empty(oagis:Qualification)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty may not contain oagis:Qualification</assert>
      <assert test="empty(oagis:Rating)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty may not contain oagis:Rating</assert>
      <assert test="empty(oagis:Currency)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty may not contain oagis:Currency</assert>
      <assert test="empty(@active)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty may not contain @active</assert>
      <assert test="empty(oagis:TaxExemptInd)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty may not contain oagis:TaxExemptInd</assert>
      <assert test="empty(oagis:AlternatePartyIds)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty may not contain oagis:AlternatePartyIds</assert>
      <assert test="empty(oagis:PaymentMethod)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty may not contain oagis:PaymentMethod</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses">
      <assert test="empty(oagis:Address)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses may not contain oagis:Address</assert>
      <assert test="empty(oagis:ShippingAddress)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses may not contain oagis:ShippingAddress</assert>
      <assert test="empty(oagis:SecondaryAddress)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses may not contain oagis:SecondaryAddress</assert>
      <assert test="empty(oagis:DropShipAddress)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses may not contain oagis:DropShipAddress</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses/oagis:PrimaryAddress">
      <assert test="empty(oagis:TaxJurisdiction)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses/oagis:PrimaryAddress may not contain oagis:TaxJurisdiction</assert>
      <assert test="empty(oagis:UserArea)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses/oagis:PrimaryAddress may not contain oagis:UserArea</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses/oagis:PrimaryAddress/oagis:AddressId">
      <assert test="empty(@qualifyingAgency)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses/oagis:PrimaryAddress/oagis:AddressId may not contain @qualifyingAgency</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses/oagis:PrimaryAddress/oagis:Description">
      <assert test="empty(@owner)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses/oagis:PrimaryAddress/oagis:Description may not contain @owner</assert>
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses/oagis:PrimaryAddress/oagis:Description may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts">
      <assert test="empty(oagis:AccountingContact)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts may not contain oagis:AccountingContact</assert>
      <assert test="empty(oagis:SalesContact)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts may not contain oagis:SalesContact</assert>
      <assert test="empty(oagis:DeliverToContact)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts may not contain oagis:DeliverToContact</assert>
      <assert test="empty(oagis:MarketingContact)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts may not contain oagis:MarketingContact</assert>
      <assert test="empty(oagis:SecondaryContact)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts may not contain oagis:SecondaryContact</assert>
      <assert test="empty(oagis:Planner)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts may not contain oagis:Planner</assert>
      <assert test="empty(oagis:Requester)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts may not contain oagis:Requester</assert>
      <assert test="empty(oagis:PrimaryContact)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts may not contain oagis:PrimaryContact</assert>
      <assert test="empty(oagis:SalesPerson)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts may not contain oagis:SalesPerson</assert>
      <assert test="empty(oagis:ContactAbs)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts may not contain oagis:ContactAbs</assert>
      <assert test="empty(oagis:Buyer)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts may not contain oagis:Buyer</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact">
      <assert test="empty(oagis:UserArea)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact may not contain oagis:UserArea</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses">
      <assert test="empty(oagis:ShippingAddress)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses may not contain oagis:ShippingAddress</assert>
      <assert test="empty(oagis:SecondaryAddress)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses may not contain oagis:SecondaryAddress</assert>
      <assert test="empty(oagis:DropShipAddress)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses may not contain oagis:DropShipAddress</assert>
      <assert test="empty(oagis:Address)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses may not contain oagis:Address</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress">
      <assert test="empty(oagis:TaxJurisdiction)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may not contain oagis:TaxJurisdiction</assert>
      <assert test="empty(oagis:UserArea)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may not contain oagis:UserArea</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:AddressId">
      <assert test="empty(@qualifyingAgency)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:AddressId may not contain @qualifyingAgency</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:Description">
      <assert test="empty(@owner)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:Description may not contain @owner</assert>
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:Description may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Description">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Description may not contain @lang</assert>
      <assert test="empty(@owner)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Description may not contain @owner</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person">
      <assert test="empty(oagis:PersonCode)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person may not contain oagis:PersonCode</assert>
      <assert test="empty(oagis:UserArea)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person may not contain oagis:UserArea</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName">
      <assert test="empty(oagis:UserArea)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may not contain oagis:UserArea</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:FamilyName">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:FamilyName may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:FormattedName">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:FormattedName may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:GivenName">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:GivenName may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:MiddleName">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:MiddleName may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:PreferredGivenName">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:PreferredGivenName may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:Salutation">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:Salutation may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:Suffix">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:Suffix may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Description">
      <assert test="empty(@owner)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Description may not contain @owner</assert>
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Description may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Name">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Name may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:PartyId">
      <assert test="empty(oagis:SCAC)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:PartyId may not contain oagis:SCAC</assert>
      <assert test="empty(oagis:DUNS)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:PartyId may not contain oagis:DUNS</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty">
      <assert test="empty(oagis:TaxExemptInd)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty may not contain oagis:TaxExemptInd</assert>
      <assert test="empty(oagis:CorrespondenceLanguage)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty may not contain oagis:CorrespondenceLanguage</assert>
      <assert test="empty(oagis:AlternatePartyIds)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty may not contain oagis:AlternatePartyIds</assert>
      <assert test="empty(@oneTime)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty may not contain @oneTime</assert>
      <assert test="empty(oagis:GLEntity)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty may not contain oagis:GLEntity</assert>
      <assert test="empty(oagis:TermId)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty may not contain oagis:TermId</assert>
      <assert test="empty(oagis:UserArea)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty may not contain oagis:UserArea</assert>
      <assert test="empty(oagis:Qualification)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty may not contain oagis:Qualification</assert>
      <assert test="empty(oagis:Rating)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty may not contain oagis:Rating</assert>
      <assert test="empty(@active)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty may not contain @active</assert>
      <assert test="empty(oagis:PaymentMethod)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty may not contain oagis:PaymentMethod</assert>
      <assert test="empty(oagis:Attachments)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty may not contain oagis:Attachments</assert>
      <assert test="empty(oagis:Currency)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty may not contain oagis:Currency</assert>
      <assert test="empty(oagis:Business)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty may not contain oagis:Business</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses">
      <assert test="empty(oagis:DropShipAddress)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses may not contain oagis:DropShipAddress</assert>
      <assert test="empty(oagis:SecondaryAddress)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses may not contain oagis:SecondaryAddress</assert>
      <assert test="empty(oagis:ShippingAddress)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses may not contain oagis:ShippingAddress</assert>
      <assert test="empty(oagis:Address)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses may not contain oagis:Address</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses/oagis:PrimaryAddress">
      <assert test="empty(oagis:UserArea)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses/oagis:PrimaryAddress may not contain oagis:UserArea</assert>
      <assert test="empty(oagis:TaxJurisdiction)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses/oagis:PrimaryAddress may not contain oagis:TaxJurisdiction</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses/oagis:PrimaryAddress/oagis:AddressId">
      <assert test="empty(@qualifyingAgency)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses/oagis:PrimaryAddress/oagis:AddressId may not contain @qualifyingAgency</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses/oagis:PrimaryAddress/oagis:Description">
      <assert test="empty(@owner)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses/oagis:PrimaryAddress/oagis:Description may not contain @owner</assert>
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses/oagis:PrimaryAddress/oagis:Description may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts">
      <assert test="empty(oagis:SalesPerson)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts may not contain oagis:SalesPerson</assert>
      <assert test="empty(oagis:Requester)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts may not contain oagis:Requester</assert>
      <assert test="empty(oagis:AccountingContact)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts may not contain oagis:AccountingContact</assert>
      <assert test="empty(oagis:SalesContact)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts may not contain oagis:SalesContact</assert>
      <assert test="empty(oagis:SecondaryContact)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts may not contain oagis:SecondaryContact</assert>
      <assert test="empty(oagis:DeliverToContact)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts may not contain oagis:DeliverToContact</assert>
      <assert test="empty(oagis:ContactAbs)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts may not contain oagis:ContactAbs</assert>
      <assert test="empty(oagis:Buyer)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts may not contain oagis:Buyer</assert>
      <assert test="empty(oagis:MarketingContact)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts may not contain oagis:MarketingContact</assert>
      <assert test="empty(oagis:Planner)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts may not contain oagis:Planner</assert>
      <assert test="empty(oagis:PrimaryContact)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts may not contain oagis:PrimaryContact</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact">
      <assert test="empty(oagis:UserArea)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact may not contain oagis:UserArea</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses">
      <assert test="empty(oagis:Address)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses may not contain oagis:Address</assert>
      <assert test="empty(oagis:DropShipAddress)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses may not contain oagis:DropShipAddress</assert>
      <assert test="empty(oagis:ShippingAddress)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses may not contain oagis:ShippingAddress</assert>
      <assert test="empty(oagis:SecondaryAddress)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses may not contain oagis:SecondaryAddress</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress">
      <assert test="empty(oagis:TaxJurisdiction)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may not contain oagis:TaxJurisdiction</assert>
      <assert test="empty(oagis:UserArea)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may not contain oagis:UserArea</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:AddressId">
      <assert test="empty(@qualifyingAgency)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:AddressId may not contain @qualifyingAgency</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:Description">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:Description may not contain @lang</assert>
      <assert test="empty(@owner)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:Description may not contain @owner</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Description">
      <assert test="empty(@owner)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Description may not contain @owner</assert>
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Description may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person">
      <assert test="empty(oagis:PersonCode)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person may not contain oagis:PersonCode</assert>
      <assert test="empty(oagis:UserArea)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person may not contain oagis:UserArea</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName">
      <assert test="empty(oagis:UserArea)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may not contain oagis:UserArea</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:FamilyName">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:FamilyName may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:FormattedName">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:FormattedName may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:GivenName">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:GivenName may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:MiddleName">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:MiddleName may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:PreferredGivenName">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:PreferredGivenName may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:Salutation">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:Salutation may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:Suffix">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:Suffix may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Description">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Description may not contain @lang</assert>
      <assert test="empty(@owner)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Description may not contain @owner</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Name">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Name may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:PartyId">
      <assert test="empty(oagis:SCAC)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:PartyId may not contain oagis:SCAC</assert>
      <assert test="empty(oagis:DUNS)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:PartyId may not contain oagis:DUNS</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:PaymentTerms">
      <assert test="empty(oagis:LineNumber)">oagis:Invoice/oagis:Header/oagis:PaymentTerms may not contain oagis:LineNumber</assert>
      <assert test="empty(oagis:TermId)">oagis:Invoice/oagis:Header/oagis:PaymentTerms may not contain oagis:TermId</assert>
      <assert test="empty(oagis:ProximoNumberMonth)">oagis:Invoice/oagis:Header/oagis:PaymentTerms may not contain oagis:ProximoNumberMonth</assert>
      <assert test="empty(oagis:UserArea)">oagis:Invoice/oagis:Header/oagis:PaymentTerms may not contain oagis:UserArea</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:PaymentTerms/oagis:Description">
      <assert test="empty(@owner)">oagis:Invoice/oagis:Header/oagis:PaymentTerms/oagis:Description may not contain @owner</assert>
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:PaymentTerms/oagis:Description may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Tax">
      <assert test="empty(oagis:TaxJurisdiction)">oagis:Invoice/oagis:Header/oagis:Tax may not contain oagis:TaxJurisdiction</assert>
      <assert test="empty(oagis:Tax)">oagis:Invoice/oagis:Header/oagis:Tax may not contain oagis:Tax</assert>
      <assert test="empty(oagis:Charges)">oagis:Invoice/oagis:Header/oagis:Tax may not contain oagis:Charges</assert>
      <assert test="empty(oagis:Description)">oagis:Invoice/oagis:Header/oagis:Tax may not contain oagis:Description</assert>
      <assert test="empty(oagis:UserArea)">oagis:Invoice/oagis:Header/oagis:Tax may not contain oagis:UserArea</assert>
      <assert test="empty(oagis:TaxCode)">oagis:Invoice/oagis:Header/oagis:Tax may not contain oagis:TaxCode</assert>
      <assert test="empty(oagis:LineNumber)">oagis:Invoice/oagis:Header/oagis:Tax may not contain oagis:LineNumber</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements">
      <assert test="empty(hrxml:CustomerJobDescription)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobDescription</assert>
      <assert test="empty(hrxml:LocationName)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationName</assert>
      <assert test="empty(hrxml:CustomerJobCode)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobCode</assert>
      <assert test="empty(hrxml:ExternalOrderNumber)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalOrderNumber</assert>
      <assert test="empty(hrxml:Entity)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Entity</assert>
      <assert test="empty(hrxml:Shift)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Shift</assert>
      <assert test="empty(hrxml:ExternalReqNumber)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalReqNumber</assert>
      <assert test="empty(hrxml:SubEntity)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SubEntity</assert>
      <assert test="empty(hrxml:ContactName)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ContactName</assert>
      <assert test="empty(hrxml:LocationCode)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationCode</assert>
      <assert test="empty(hrxml:ManagerName)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ManagerName</assert>
      <assert test="empty(hrxml:SupervisorName)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SupervisorName</assert>
      <assert test="empty(hrxml:AccountCode)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:AccountCode</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation">
      <assert test="empty(hrxml:IntermediaryId)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:IntermediaryId</assert>
      <assert test="empty(hrxml:MasterOrderId)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:MasterOrderId</assert>
      <assert test="empty(hrxml:HumanResourceId)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:HumanResourceId</assert>
      <assert test="empty(hrxml:DocumentId)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:DocumentId</assert>
      <assert test="empty(hrxml:BillToEntityId)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:BillToEntityId</assert>
      <assert test="empty(hrxml:InvoiceId)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:InvoiceId</assert>
      <assert test="empty(hrxml:OrderId)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:OrderId</assert>
      <assert test="empty(hrxml:StaffingOrganizationId)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:StaffingOrganizationId</assert>
      <assert test="empty(hrxml:PositionId)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:PositionId</assert>
      <assert test="empty(hrxml:UserArea)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:UserArea</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId">
      <assert test="empty(@validFrom)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId may not contain @validFrom</assert>
      <assert test="empty(@validTo)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId may not contain @validTo</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId/hrxml:IdValue">
      <assert test="empty(@name)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId">
      <assert test="empty(@validTo)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may not contain @validTo</assert>
      <assert test="empty(@validFrom)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may not contain @validFrom</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/hrxml:IdValue">
      <assert test="empty(@name)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId">
      <assert test="empty(@validFrom)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may not contain @validFrom</assert>
      <assert test="empty(@validTo)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may not contain @validTo</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/hrxml:IdValue">
      <assert test="empty(@name)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId">
      <assert test="empty(@validTo)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may not contain @validTo</assert>
      <assert test="empty(@validFrom)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may not contain @validFrom</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/hrxml:IdValue">
      <assert test="empty(@name)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId">
      <assert test="empty(@validTo)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId may not contain @validTo</assert>
      <assert test="empty(@validFrom)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId may not contain @validFrom</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/hrxml:IdValue">
      <assert test="empty(@name)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization">
      <assert test="empty(hrxml:ReferenceIdInfo)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization may not contain hrxml:ReferenceIdInfo</assert>
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization may not contain @lang</assert>
      <assert test="empty(hrxml:UserArea)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization may not contain hrxml:UserArea</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization">
      <assert test="empty(hrxml:UserArea)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization may not contain hrxml:UserArea</assert>
      <assert test="empty(hrxml:MissionStatement)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization may not contain hrxml:MissionStatement</assert>
      <assert test="empty(hrxml:IsPublicCompany)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization may not contain hrxml:IsPublicCompany</assert>
      <assert test="empty(hrxml:IndustryCode)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization may not contain hrxml:IndustryCode</assert>
      <assert test="empty(hrxml:Description)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization may not contain hrxml:Description</assert>
      <assert test="empty(hrxml:ValueStatement)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization may not contain hrxml:ValueStatement</assert>
      <assert test="empty(hrxml:OrganizationalUnit)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization may not contain hrxml:OrganizationalUnit</assert>
      <assert test="empty(hrxml:DunsNumber)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization may not contain hrxml:DunsNumber</assert>
      <assert test="empty(hrxml:ContactInfo)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization may not contain hrxml:ContactInfo</assert>
      <assert test="empty(hrxml:TaxId)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization may not contain hrxml:TaxId</assert>
      <assert test="empty(hrxml:LegalClassification)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization may not contain hrxml:LegalClassification</assert>
      <assert test="empty(hrxml:OrganizationId)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization may not contain hrxml:OrganizationId</assert>
      <assert test="empty(hrxml:LegalId)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization may not contain hrxml:LegalId</assert>
      <assert test="empty(hrxml:Stock)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization may not contain hrxml:Stock</assert>
      <assert test="empty(hrxml:RelatedOrganization)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization may not contain hrxml:RelatedOrganization</assert>
      <assert test="empty(hrxml:WorkSite)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization may not contain hrxml:WorkSite</assert>
      <assert test="empty(hrxml:Headcount)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization may not contain hrxml:Headcount</assert>
      <assert test="empty(hrxml:DoingBusinessAs)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization may not contain hrxml:DoingBusinessAs</assert>
      <assert test="empty(hrxml:InternetDomainName)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization may not contain hrxml:InternetDomainName</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo">
      <assert test="empty(hrxml:CollectiveAgreement)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo may not contain hrxml:CollectiveAgreement</assert>
      <assert test="empty(hrxml:PaymentCondition)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo may not contain hrxml:PaymentCondition</assert>
      <assert test="empty(hrxml:TaxEvaluation)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo may not contain hrxml:TaxEvaluation</assert>
      <assert test="empty(hrxml:Capital)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo may not contain hrxml:Capital</assert>
      <assert test="empty(hrxml:OrganizationalUnitId)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo may not contain hrxml:OrganizationalUnitId</assert>
      <assert test="empty(hrxml:OrganizationId)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo may not contain hrxml:OrganizationId</assert>
      <assert test="empty(hrxml:UserArea)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo may not contain hrxml:UserArea</assert>
      <assert test="empty(hrxml:VATRate)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo may not contain hrxml:VATRate</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo/hrxml:BankAccountInfo">
      <assert test="empty(hrxml:BankAccountForeign)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo/hrxml:BankAccountInfo may not contain hrxml:BankAccountForeign</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line">
      <assert test="empty(oagis:Note)">oagis:Invoice/oagis:Line may not contain oagis:Note</assert>
      <assert test="empty(oagis:OrderItem)">oagis:Invoice/oagis:Line may not contain oagis:OrderItem</assert>
      <assert test="empty(oagis:PackingMaterial)">oagis:Invoice/oagis:Line may not contain oagis:PackingMaterial</assert>
      <assert test="empty(oagis:ExtendedPrice)">oagis:Invoice/oagis:Line may not contain oagis:ExtendedPrice</assert>
      <assert test="empty(oagis:Attachments)">oagis:Invoice/oagis:Line may not contain oagis:Attachments</assert>
      <assert test="empty(oagis:TransportationTerm)">oagis:Invoice/oagis:Line may not contain oagis:TransportationTerm</assert>
      <assert test="empty(oagis:SubstitutionAllowedInd)">oagis:Invoice/oagis:Line may not contain oagis:SubstitutionAllowedInd</assert>
      <assert test="empty(oagis:ShipNote)">oagis:Invoice/oagis:Line may not contain oagis:ShipNote</assert>
      <assert test="empty(oagis:ActualTemperature)">oagis:Invoice/oagis:Line may not contain oagis:ActualTemperature</assert>
      <assert test="empty(oagis:ShipPriorToDueDateInd)">oagis:Invoice/oagis:Line may not contain oagis:ShipPriorToDueDateInd</assert>
      <assert test="empty(oagis:Parties)">oagis:Invoice/oagis:Line may not contain oagis:Parties</assert>
      <assert test="empty(oagis:UnitPrice)">oagis:Invoice/oagis:Line may not contain oagis:UnitPrice</assert>
      <assert test="empty(oagis:License)">oagis:Invoice/oagis:Line may not contain oagis:License</assert>
      <assert test="empty(oagis:MinimumTemperature)">oagis:Invoice/oagis:Line may not contain oagis:MinimumTemperature</assert>
      <assert test="empty(oagis:Allowance)">oagis:Invoice/oagis:Line may not contain oagis:Allowance</assert>
      <assert test="empty(oagis:ProjectResource)">oagis:Invoice/oagis:Line may not contain oagis:ProjectResource</assert>
      <assert test="empty(oagis:FreightClass)">oagis:Invoice/oagis:Line may not contain oagis:FreightClass</assert>
      <assert test="empty(oagis:OrderStatus)">oagis:Invoice/oagis:Line may not contain oagis:OrderStatus</assert>
      <assert test="empty(oagis:Distribution)">oagis:Invoice/oagis:Line may not contain oagis:Distribution</assert>
      <assert test="empty(oagis:PromisedShipDate)">oagis:Invoice/oagis:Line may not contain oagis:PromisedShipDate</assert>
      <assert test="empty(oagis:PromisedDeliveryDate)">oagis:Invoice/oagis:Line may not contain oagis:PromisedDeliveryDate</assert>
      <assert test="empty(oagis:TotalAmount)">oagis:Invoice/oagis:Line may not contain oagis:TotalAmount</assert>
      <assert test="empty(oagis:DropShipInd)">oagis:Invoice/oagis:Line may not contain oagis:DropShipInd</assert>
      <assert test="empty(oagis:PaymentTerms)">oagis:Invoice/oagis:Line may not contain oagis:PaymentTerms</assert>
      <assert test="empty(oagis:ShippingNote)">oagis:Invoice/oagis:Line may not contain oagis:ShippingNote</assert>
      <assert test="empty(oagis:SpecialHandlingNote)">oagis:Invoice/oagis:Line may not contain oagis:SpecialHandlingNote</assert>
      <assert test="empty(oagis:LoadingTemperature)">oagis:Invoice/oagis:Line may not contain oagis:LoadingTemperature</assert>
      <assert test="empty(oagis:DeliveryTemperature)">oagis:Invoice/oagis:Line may not contain oagis:DeliveryTemperature</assert>
      <assert test="empty(oagis:MaximumTemperature)">oagis:Invoice/oagis:Line may not contain oagis:MaximumTemperature</assert>
      <assert test="empty(oagis:TaxWithholdingExempt)">oagis:Invoice/oagis:Line may not contain oagis:TaxWithholdingExempt</assert>
      <assert test="empty(oagis:ProjectActivity)">oagis:Invoice/oagis:Line may not contain oagis:ProjectActivity</assert>
      <assert test="empty(oagis:BackOrderedQuantity)">oagis:Invoice/oagis:Line may not contain oagis:BackOrderedQuantity</assert>
      <assert test="empty(oagis:NeedDeliveryDate)">oagis:Invoice/oagis:Line may not contain oagis:NeedDeliveryDate</assert>
      <assert test="empty(oagis:OrderQuantity)">oagis:Invoice/oagis:Line may not contain oagis:OrderQuantity</assert>
      <assert test="empty(oagis:EarliestShipDate)">oagis:Invoice/oagis:Line may not contain oagis:EarliestShipDate</assert>
      <assert test="empty(oagis:Priority)">oagis:Invoice/oagis:Line may not contain oagis:Priority</assert>
      <assert test="empty(oagis:BackOrderedInd)">oagis:Invoice/oagis:Line may not contain oagis:BackOrderedInd</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Charges">
      <assert test="empty(oagis:TransportToLocationCharge)">oagis:Invoice/oagis:Line/oagis:Charges may not contain oagis:TransportToLocationCharge</assert>
      <assert test="empty(oagis:BasicFreightCharge)">oagis:Invoice/oagis:Line/oagis:Charges may not contain oagis:BasicFreightCharge</assert>
      <assert test="empty(oagis:AllCostsToLocationCharge)">oagis:Invoice/oagis:Line/oagis:Charges may not contain oagis:AllCostsToLocationCharge</assert>
      <assert test="empty(oagis:WeightValuationCharge)">oagis:Invoice/oagis:Line/oagis:Charges may not contain oagis:WeightValuationCharge</assert>
      <assert test="empty(oagis:SpecificAmountCharge)">oagis:Invoice/oagis:Line/oagis:Charges may not contain oagis:SpecificAmountCharge</assert>
      <assert test="empty(oagis:Charge)">oagis:Invoice/oagis:Line/oagis:Charges may not contain oagis:Charge</assert>
      <assert test="empty(oagis:SupplementaryCharge)">oagis:Invoice/oagis:Line/oagis:Charges may not contain oagis:SupplementaryCharge</assert>
      <assert test="empty(oagis:DestinationHaulageCharge)">oagis:Invoice/oagis:Line/oagis:Charges may not contain oagis:DestinationHaulageCharge</assert>
      <assert test="empty(oagis:DestinationPortCharge)">oagis:Invoice/oagis:Line/oagis:Charges may not contain oagis:DestinationPortCharge</assert>
      <assert test="empty(oagis:AdditionalCharge)">oagis:Invoice/oagis:Line/oagis:Charges may not contain oagis:AdditionalCharge</assert>
      <assert test="empty(oagis:TransportPlusAdditionalCharge)">oagis:Invoice/oagis:Line/oagis:Charges may not contain oagis:TransportPlusAdditionalCharge</assert>
      <assert test="empty(oagis:MiscellaneousCharge)">oagis:Invoice/oagis:Line/oagis:Charges may not contain oagis:MiscellaneousCharge</assert>
      <assert test="empty(oagis:OriginPortCharge)">oagis:Invoice/oagis:Line/oagis:Charges may not contain oagis:OriginPortCharge</assert>
      <assert test="empty(oagis:DistribursmentCharge)">oagis:Invoice/oagis:Line/oagis:Charges may not contain oagis:DistribursmentCharge</assert>
      <assert test="empty(oagis:TransportationCharge)">oagis:Invoice/oagis:Line/oagis:Charges may not contain oagis:TransportationCharge</assert>
      <assert test="empty(oagis:AllCharge)">oagis:Invoice/oagis:Line/oagis:Charges may not contain oagis:AllCharge</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Charges/oagis:TotalCharge">
      <assert test="empty(oagis:Id)">oagis:Invoice/oagis:Line/oagis:Charges/oagis:TotalCharge may not contain oagis:Id</assert>
      <assert test="empty(oagis:UserArea)">oagis:Invoice/oagis:Line/oagis:Charges/oagis:TotalCharge may not contain oagis:UserArea</assert>
      <assert test="empty(oagis:Cost)">oagis:Invoice/oagis:Line/oagis:Charges/oagis:TotalCharge may not contain oagis:Cost</assert>
      <assert test="empty(oagis:Distribution)">oagis:Invoice/oagis:Line/oagis:Charges/oagis:TotalCharge may not contain oagis:Distribution</assert>
      <assert test="empty(oagis:Description)">oagis:Invoice/oagis:Line/oagis:Charges/oagis:TotalCharge may not contain oagis:Description</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Description">
      <assert test="empty(@owner)">oagis:Invoice/oagis:Line/oagis:Description may not contain @owner</assert>
      <assert test="empty(@lang)">oagis:Invoice/oagis:Line/oagis:Description may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:DocumentReferences">
      <assert test="empty(oagis:RequisitionDocumentReference)">oagis:Invoice/oagis:Line/oagis:DocumentReferences may not contain oagis:RequisitionDocumentReference</assert>
      <assert test="empty(oagis:CatalogDocumentReference)">oagis:Invoice/oagis:Line/oagis:DocumentReferences may not contain oagis:CatalogDocumentReference</assert>
      <assert test="empty(oagis:PurchaseOrderDocumentReference)">oagis:Invoice/oagis:Line/oagis:DocumentReferences may not contain oagis:PurchaseOrderDocumentReference</assert>
      <assert test="empty(oagis:VoucherDocumentReference)">oagis:Invoice/oagis:Line/oagis:DocumentReferences may not contain oagis:VoucherDocumentReference</assert>
      <assert test="empty(oagis:SalesOrderDocumentReference)">oagis:Invoice/oagis:Line/oagis:DocumentReferences may not contain oagis:SalesOrderDocumentReference</assert>
      <assert test="empty(oagis:RFQDocumentReference)">oagis:Invoice/oagis:Line/oagis:DocumentReferences may not contain oagis:RFQDocumentReference</assert>
      <assert test="empty(oagis:LedgerDocumentReference)">oagis:Invoice/oagis:Line/oagis:DocumentReferences may not contain oagis:LedgerDocumentReference</assert>
      <assert test="empty(oagis:ProjectReference)">oagis:Invoice/oagis:Line/oagis:DocumentReferences may not contain oagis:ProjectReference</assert>
      <assert test="empty(oagis:UOMGroupReference)">oagis:Invoice/oagis:Line/oagis:DocumentReferences may not contain oagis:UOMGroupReference</assert>
      <assert test="empty(oagis:ContractDocumentReference)">oagis:Invoice/oagis:Line/oagis:DocumentReferences may not contain oagis:ContractDocumentReference</assert>
      <assert test="empty(oagis:MaintenanceOrderReference)">oagis:Invoice/oagis:Line/oagis:DocumentReferences may not contain oagis:MaintenanceOrderReference</assert>
      <assert test="empty(oagis:ReceiptDocumentReference)">oagis:Invoice/oagis:Line/oagis:DocumentReferences may not contain oagis:ReceiptDocumentReference</assert>
      <assert test="empty(oagis:QuoteDocumentReference)">oagis:Invoice/oagis:Line/oagis:DocumentReferences may not contain oagis:QuoteDocumentReference</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference">
      <assert test="empty(oagis:Status)">oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:Status</assert>
      <assert test="empty(oagis:Note)">oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:Note</assert>
      <assert test="empty(oagis:Name)">oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:Name</assert>
      <assert test="empty(oagis:Description)">oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:Description</assert>
      <assert test="empty(oagis:DocumentDate)">oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:DocumentDate</assert>
      <assert test="empty(oagis:UserArea)">oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:UserArea</assert>
      <assert test="empty(oagis:ScheduleLineNumber)">oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:ScheduleLineNumber</assert>
      <assert test="empty(oagis:Usage)">oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:Usage</assert>
      <assert test="empty(oagis:SubLineNumber)">oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:SubLineNumber</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds">
      <assert test="empty(oagis:CustomerDocumentId)">oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds may not contain oagis:CustomerDocumentId</assert>
      <assert test="empty(oagis:ShippersDocumentId)">oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds may not contain oagis:ShippersDocumentId</assert>
      <assert test="empty(oagis:LogisticsProviderDocumentId)">oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds may not contain oagis:LogisticsProviderDocumentId</assert>
      <assert test="empty(oagis:CarrierDocumentId)">oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds may not contain oagis:CarrierDocumentId</assert>
      <assert test="empty(oagis:SupplierDocumentId)">oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds may not contain oagis:SupplierDocumentId</assert>
      <assert test="empty(oagis:BrokerDocumentId)">oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds may not contain oagis:BrokerDocumentId</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds/oagis:DocumentId">
      <assert test="empty(oagis:Revision)">oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds/oagis:DocumentId may not contain oagis:Revision</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line">
      <assert test="empty(oagis:EarliestShipDate)">oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:EarliestShipDate</assert>
      <assert test="empty(oagis:ActualTemperature)">oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:ActualTemperature</assert>
      <assert test="empty(oagis:License)">oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:License</assert>
      <assert test="empty(oagis:TaxWithholdingExempt)">oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:TaxWithholdingExempt</assert>
      <assert test="empty(oagis:FreightClass)">oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:FreightClass</assert>
      <assert test="empty(oagis:Priority)">oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:Priority</assert>
      <assert test="empty(oagis:UnitPrice)">oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:UnitPrice</assert>
      <assert test="empty(oagis:OrderItem)">oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:OrderItem</assert>
      <assert test="empty(oagis:ProjectActivity)">oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:ProjectActivity</assert>
      <assert test="empty(oagis:LoadingTemperature)">oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:LoadingTemperature</assert>
      <assert test="empty(oagis:TransportationTerm)">oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:TransportationTerm</assert>
      <assert test="empty(oagis:TotalAmount)">oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:TotalAmount</assert>
      <assert test="empty(oagis:ProjectResource)">oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:ProjectResource</assert>
      <assert test="empty(oagis:MaximumTemperature)">oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:MaximumTemperature</assert>
      <assert test="empty(oagis:SpecialHandlingNote)">oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:SpecialHandlingNote</assert>
      <assert test="empty(oagis:MinimumTemperature)">oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:MinimumTemperature</assert>
      <assert test="empty(oagis:ShippingNote)">oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:ShippingNote</assert>
      <assert test="empty(oagis:NeedDeliveryDate)">oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:NeedDeliveryDate</assert>
      <assert test="empty(oagis:BackOrderedInd)">oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:BackOrderedInd</assert>
      <assert test="empty(oagis:Distribution)">oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:Distribution</assert>
      <assert test="empty(oagis:DeliveryTemperature)">oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:DeliveryTemperature</assert>
      <assert test="empty(oagis:Line)">oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:Line</assert>
      <assert test="empty(oagis:DropShipInd)">oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:DropShipInd</assert>
      <assert test="empty(oagis:BackOrderedQuantity)">oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:BackOrderedQuantity</assert>
      <assert test="empty(oagis:Parties)">oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:Parties</assert>
      <assert test="empty(oagis:ShipNote)">oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:ShipNote</assert>
      <assert test="empty(oagis:ExtendedPrice)">oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:ExtendedPrice</assert>
      <assert test="empty(oagis:Note)">oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:Note</assert>
      <assert test="empty(oagis:PackingMaterial)">oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:PackingMaterial</assert>
      <assert test="empty(oagis:Allowance)">oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:Allowance</assert>
      <assert test="empty(oagis:SubstitutionAllowedInd)">oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:SubstitutionAllowedInd</assert>
      <assert test="empty(oagis:ShipPriorToDueDateInd)">oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:ShipPriorToDueDateInd</assert>
      <assert test="empty(oagis:PaymentTerms)">oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:PaymentTerms</assert>
      <assert test="empty(oagis:Attachments)">oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:Attachments</assert>
      <assert test="empty(oagis:PromisedShipDate)">oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:PromisedShipDate</assert>
      <assert test="empty(oagis:OrderQuantity)">oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:OrderQuantity</assert>
      <assert test="empty(oagis:OrderStatus)">oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:OrderStatus</assert>
      <assert test="empty(oagis:PromisedDeliveryDate)">oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:PromisedDeliveryDate</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges">
      <assert test="empty(oagis:TransportToLocationCharge)">oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges may not contain oagis:TransportToLocationCharge</assert>
      <assert test="empty(oagis:MiscellaneousCharge)">oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges may not contain oagis:MiscellaneousCharge</assert>
      <assert test="empty(oagis:DestinationHaulageCharge)">oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges may not contain oagis:DestinationHaulageCharge</assert>
      <assert test="empty(oagis:DestinationPortCharge)">oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges may not contain oagis:DestinationPortCharge</assert>
      <assert test="empty(oagis:BasicFreightCharge)">oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges may not contain oagis:BasicFreightCharge</assert>
      <assert test="empty(oagis:WeightValuationCharge)">oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges may not contain oagis:WeightValuationCharge</assert>
      <assert test="empty(oagis:AllCostsToLocationCharge)">oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges may not contain oagis:AllCostsToLocationCharge</assert>
      <assert test="empty(oagis:DistribursmentCharge)">oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges may not contain oagis:DistribursmentCharge</assert>
      <assert test="empty(oagis:Charge)">oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges may not contain oagis:Charge</assert>
      <assert test="empty(oagis:OriginPortCharge)">oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges may not contain oagis:OriginPortCharge</assert>
      <assert test="empty(oagis:TransportationCharge)">oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges may not contain oagis:TransportationCharge</assert>
      <assert test="empty(oagis:SupplementaryCharge)">oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges may not contain oagis:SupplementaryCharge</assert>
      <assert test="empty(oagis:SpecificAmountCharge)">oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges may not contain oagis:SpecificAmountCharge</assert>
      <assert test="empty(oagis:AdditionalCharge)">oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges may not contain oagis:AdditionalCharge</assert>
      <assert test="empty(oagis:TransportPlusAdditionalCharge)">oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges may not contain oagis:TransportPlusAdditionalCharge</assert>
      <assert test="empty(oagis:AllCharge)">oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges may not contain oagis:AllCharge</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges/oagis:TotalCharge">
      <assert test="empty(oagis:Description)">oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges/oagis:TotalCharge may not contain oagis:Description</assert>
      <assert test="empty(oagis:Id)">oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges/oagis:TotalCharge may not contain oagis:Id</assert>
      <assert test="empty(oagis:Cost)">oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges/oagis:TotalCharge may not contain oagis:Cost</assert>
      <assert test="empty(oagis:Distribution)">oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges/oagis:TotalCharge may not contain oagis:Distribution</assert>
      <assert test="empty(oagis:UserArea)">oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges/oagis:TotalCharge may not contain oagis:UserArea</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:Description">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Line/oagis:Line/oagis:Description may not contain @lang</assert>
      <assert test="empty(@owner)">oagis:Invoice/oagis:Line/oagis:Line/oagis:Description may not contain @owner</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences">
      <assert test="empty(oagis:PurchaseOrderDocumentReference)">oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences may not contain oagis:PurchaseOrderDocumentReference</assert>
      <assert test="empty(oagis:UOMGroupReference)">oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences may not contain oagis:UOMGroupReference</assert>
      <assert test="empty(oagis:LedgerDocumentReference)">oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences may not contain oagis:LedgerDocumentReference</assert>
      <assert test="empty(oagis:MaintenanceOrderReference)">oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences may not contain oagis:MaintenanceOrderReference</assert>
      <assert test="empty(oagis:SalesOrderDocumentReference)">oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences may not contain oagis:SalesOrderDocumentReference</assert>
      <assert test="empty(oagis:ContractDocumentReference)">oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences may not contain oagis:ContractDocumentReference</assert>
      <assert test="empty(oagis:RFQDocumentReference)">oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences may not contain oagis:RFQDocumentReference</assert>
      <assert test="empty(oagis:ReceiptDocumentReference)">oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences may not contain oagis:ReceiptDocumentReference</assert>
      <assert test="empty(oagis:CatalogDocumentReference)">oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences may not contain oagis:CatalogDocumentReference</assert>
      <assert test="empty(oagis:RequisitionDocumentReference)">oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences may not contain oagis:RequisitionDocumentReference</assert>
      <assert test="empty(oagis:QuoteDocumentReference)">oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences may not contain oagis:QuoteDocumentReference</assert>
      <assert test="empty(oagis:ProjectReference)">oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences may not contain oagis:ProjectReference</assert>
      <assert test="empty(oagis:VoucherDocumentReference)">oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences may not contain oagis:VoucherDocumentReference</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference">
      <assert test="empty(oagis:Name)">oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:Name</assert>
      <assert test="empty(oagis:Description)">oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:Description</assert>
      <assert test="empty(oagis:ScheduleLineNumber)">oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:ScheduleLineNumber</assert>
      <assert test="empty(oagis:SubLineNumber)">oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:SubLineNumber</assert>
      <assert test="empty(oagis:DocumentDate)">oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:DocumentDate</assert>
      <assert test="empty(oagis:Status)">oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:Status</assert>
      <assert test="empty(oagis:UserArea)">oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:UserArea</assert>
      <assert test="empty(oagis:Usage)">oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:Usage</assert>
      <assert test="empty(oagis:Note)">oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:Note</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds">
      <assert test="empty(oagis:CarrierDocumentId)">oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds may not contain oagis:CarrierDocumentId</assert>
      <assert test="empty(oagis:LogisticsProviderDocumentId)">oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds may not contain oagis:LogisticsProviderDocumentId</assert>
      <assert test="empty(oagis:SupplierDocumentId)">oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds may not contain oagis:SupplierDocumentId</assert>
      <assert test="empty(oagis:ShippersDocumentId)">oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds may not contain oagis:ShippersDocumentId</assert>
      <assert test="empty(oagis:BrokerDocumentId)">oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds may not contain oagis:BrokerDocumentId</assert>
      <assert test="empty(oagis:CustomerDocumentId)">oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds may not contain oagis:CustomerDocumentId</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds/oagis:DocumentId">
      <assert test="empty(oagis:Revision)">oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds/oagis:DocumentId may not contain oagis:Revision</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:Price">
      <assert test="empty(oagis:FunctionalAmout)">oagis:Invoice/oagis:Line/oagis:Line/oagis:Price may not contain oagis:FunctionalAmout</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:Tax">
      <assert test="empty(oagis:TaxJurisdiction)">oagis:Invoice/oagis:Line/oagis:Line/oagis:Tax may not contain oagis:TaxJurisdiction</assert>
      <assert test="empty(oagis:Description)">oagis:Invoice/oagis:Line/oagis:Line/oagis:Tax may not contain oagis:Description</assert>
      <assert test="empty(oagis:TaxCode)">oagis:Invoice/oagis:Line/oagis:Line/oagis:Tax may not contain oagis:TaxCode</assert>
      <assert test="empty(oagis:LineNumber)">oagis:Invoice/oagis:Line/oagis:Line/oagis:Tax may not contain oagis:LineNumber</assert>
      <assert test="empty(oagis:Charges)">oagis:Invoice/oagis:Line/oagis:Line/oagis:Tax may not contain oagis:Charges</assert>
      <assert test="empty(oagis:Tax)">oagis:Invoice/oagis:Line/oagis:Line/oagis:Tax may not contain oagis:Tax</assert>
      <assert test="empty(oagis:UserArea)">oagis:Invoice/oagis:Line/oagis:Line/oagis:Tax may not contain oagis:UserArea</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData">
      <assert test="empty(hrxml:ReferenceInformation)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData may not contain hrxml:ReferenceInformation</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements">
      <assert test="empty(hrxml:Entity)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Entity</assert>
      <assert test="empty(hrxml:SupervisorName)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SupervisorName</assert>
      <assert test="empty(hrxml:ContactName)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ContactName</assert>
      <assert test="empty(hrxml:Shift)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Shift</assert>
      <assert test="empty(hrxml:ManagerName)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ManagerName</assert>
      <assert test="empty(hrxml:LocationName)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationName</assert>
      <assert test="empty(hrxml:ExternalReqNumber)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalReqNumber</assert>
      <assert test="empty(hrxml:LocationCode)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationCode</assert>
      <assert test="empty(hrxml:CustomerJobCode)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobCode</assert>
      <assert test="empty(hrxml:AccountCode)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:AccountCode</assert>
      <assert test="empty(hrxml:CustomerJobDescription)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobDescription</assert>
      <assert test="empty(hrxml:ExternalOrderNumber)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalOrderNumber</assert>
      <assert test="empty(hrxml:SubEntity)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SubEntity</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard may not contain @lang</assert>
      <assert test="empty(hrxml:UserArea)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard may not contain hrxml:UserArea</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData">
      <assert test="empty(@type)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData may not contain @type</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements">
      <assert test="empty(hrxml:Shift)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Shift</assert>
      <assert test="empty(hrxml:SupervisorName)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SupervisorName</assert>
      <assert test="empty(hrxml:CustomerJobDescription)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobDescription</assert>
      <assert test="empty(hrxml:SubEntity)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SubEntity</assert>
      <assert test="empty(hrxml:LocationCode)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationCode</assert>
      <assert test="empty(hrxml:LocationName)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationName</assert>
      <assert test="empty(hrxml:ContactName)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ContactName</assert>
      <assert test="empty(hrxml:AccountCode)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:AccountCode</assert>
      <assert test="empty(hrxml:ExternalOrderNumber)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalOrderNumber</assert>
      <assert test="empty(hrxml:ManagerName)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ManagerName</assert>
      <assert test="empty(hrxml:CustomerJobCode)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobCode</assert>
      <assert test="empty(hrxml:ExternalReqNumber)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalReqNumber</assert>
      <assert test="empty(hrxml:Entity)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Entity</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation">
      <assert test="empty(hrxml:OrderId)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:OrderId</assert>
      <assert test="empty(hrxml:HumanResourceId)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:HumanResourceId</assert>
      <assert test="empty(hrxml:BillToEntityId)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:BillToEntityId</assert>
      <assert test="empty(hrxml:InvoiceId)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:InvoiceId</assert>
      <assert test="empty(hrxml:DocumentId)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:DocumentId</assert>
      <assert test="empty(hrxml:IntermediaryId)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:IntermediaryId</assert>
      <assert test="empty(hrxml:PositionId)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:PositionId</assert>
      <assert test="empty(hrxml:UserArea)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:UserArea</assert>
      <assert test="empty(hrxml:StaffingOrganizationId)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:StaffingOrganizationId</assert>
      <assert test="empty(hrxml:MasterOrderId)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:MasterOrderId</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId">
      <assert test="empty(@validTo)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId may not contain @validTo</assert>
      <assert test="empty(@validFrom)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId may not contain @validFrom</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId/hrxml:IdValue">
      <assert test="empty(@name)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId">
      <assert test="empty(@validFrom)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may not contain @validFrom</assert>
      <assert test="empty(@validTo)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may not contain @validTo</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/hrxml:IdValue">
      <assert test="empty(@name)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId">
      <assert test="empty(@validFrom)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may not contain @validFrom</assert>
      <assert test="empty(@validTo)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may not contain @validTo</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/hrxml:IdValue">
      <assert test="empty(@name)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId">
      <assert test="empty(@validTo)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may not contain @validTo</assert>
      <assert test="empty(@validFrom)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may not contain @validFrom</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/hrxml:IdValue">
      <assert test="empty(@name)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId">
      <assert test="empty(@validTo)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId may not contain @validTo</assert>
      <assert test="empty(@validFrom)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId may not contain @validFrom</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/hrxml:IdValue">
      <assert test="empty(@name)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo">
      <assert test="empty(@approverType)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo may not contain @approverType</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Comment">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Comment may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id">
      <assert test="empty(@validFrom)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id may not contain @validFrom</assert>
      <assert test="empty(@validTo)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id may not contain @validTo</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id/hrxml:IdValue">
      <assert test="empty(@name)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName">
      <assert test="empty(@script)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName may not contain @script</assert>
      <assert test="empty(hrxml:AlternateScript)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName may not contain hrxml:AlternateScript</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id">
      <assert test="empty(@validFrom)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id may not contain @validFrom</assert>
      <assert test="empty(@validTo)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id may not contain @validTo</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id/hrxml:IdValue">
      <assert test="empty(@name)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource">
      <assert test="empty(hrxml:Resource)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource may not contain hrxml:Resource</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id">
      <assert test="empty(@validTo)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id may not contain @validTo</assert>
      <assert test="empty(@validFrom)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id may not contain @validFrom</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id/hrxml:IdValue">
      <assert test="empty(@name)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName">
      <assert test="empty(hrxml:AlternateScript)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName may not contain hrxml:AlternateScript</assert>
      <assert test="empty(@script)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName may not contain @script</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime">
      <assert test="empty(hrxml:ReportedPersonAssignment)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:ReportedPersonAssignment</assert>
      <assert test="empty(hrxml:SubmitterInfo)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:SubmitterInfo</assert>
      <assert test="empty(hrxml:Expense)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:Expense</assert>
      <assert test="empty(hrxml:AdditionalData)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:AdditionalData</assert>
      <assert test="empty(hrxml:TimeEvent)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:TimeEvent</assert>
      <assert test="empty(hrxml:ApprovalInfo)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:ApprovalInfo</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance">
      <assert test="empty(hrxml:ApprovalInfo)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance may not contain hrxml:ApprovalInfo</assert>
      <assert test="empty(hrxml:SubmitterInfo)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance may not contain hrxml:SubmitterInfo</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData">
      <assert test="empty(@type)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData may not contain @type</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData">
      <assert test="empty(hrxml:ReferenceInformation)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData may not contain hrxml:ReferenceInformation</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements">
      <assert test="empty(hrxml:ManagerName)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ManagerName</assert>
      <assert test="empty(hrxml:SupervisorName)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SupervisorName</assert>
      <assert test="empty(hrxml:Entity)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Entity</assert>
      <assert test="empty(hrxml:ContactName)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ContactName</assert>
      <assert test="empty(hrxml:SubEntity)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SubEntity</assert>
      <assert test="empty(hrxml:AccountCode)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:AccountCode</assert>
      <assert test="empty(hrxml:CustomerJobCode)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobCode</assert>
      <assert test="empty(hrxml:LocationName)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationName</assert>
      <assert test="empty(hrxml:Shift)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Shift</assert>
      <assert test="empty(hrxml:LocationCode)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationCode</assert>
      <assert test="empty(hrxml:CustomerJobDescription)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobDescription</assert>
      <assert test="empty(hrxml:ExternalOrderNumber)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalOrderNumber</assert>
      <assert test="empty(hrxml:ExternalReqNumber)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalReqNumber</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Comment">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Comment may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id">
      <assert test="empty(@validFrom)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id may not contain @validFrom</assert>
      <assert test="empty(@validTo)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id may not contain @validTo</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval">
      <assert test="empty(hrxml:Allowance)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval may not contain hrxml:Allowance</assert>
      <assert test="empty(hrxml:SubmitterInfo)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval may not contain hrxml:SubmitterInfo</assert>
      <assert test="empty(hrxml:ApprovalInfo)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval may not contain hrxml:ApprovalInfo</assert>
      <assert test="empty(hrxml:PieceWork)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval may not contain hrxml:PieceWork</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData">
      <assert test="empty(@type)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData may not contain @type</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData">
      <assert test="empty(hrxml:ReferenceInformation)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData may not contain hrxml:ReferenceInformation</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements">
      <assert test="empty(hrxml:ExternalReqNumber)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalReqNumber</assert>
      <assert test="empty(hrxml:ManagerName)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ManagerName</assert>
      <assert test="empty(hrxml:AccountCode)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:AccountCode</assert>
      <assert test="empty(hrxml:CustomerJobDescription)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobDescription</assert>
      <assert test="empty(hrxml:Entity)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Entity</assert>
      <assert test="empty(hrxml:CustomerJobCode)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobCode</assert>
      <assert test="empty(hrxml:ExternalOrderNumber)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalOrderNumber</assert>
      <assert test="empty(hrxml:LocationCode)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationCode</assert>
      <assert test="empty(hrxml:ContactName)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ContactName</assert>
      <assert test="empty(hrxml:SubEntity)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SubEntity</assert>
      <assert test="empty(hrxml:LocationName)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationName</assert>
      <assert test="empty(hrxml:Shift)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Shift</assert>
      <assert test="empty(hrxml:SupervisorName)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SupervisorName</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Comment">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Comment may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id">
      <assert test="empty(@validFrom)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id may not contain @validFrom</assert>
      <assert test="empty(@validTo)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id may not contain @validTo</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id/hrxml:IdValue">
      <assert test="empty(@name)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount">
      <assert test="empty(@period)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount may not contain @period</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:SubmitterInfo">
      <assert test="empty(hrxml:Person)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:SubmitterInfo may not contain hrxml:Person</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Price">
      <assert test="empty(oagis:FunctionalAmout)">oagis:Invoice/oagis:Line/oagis:Price may not contain oagis:FunctionalAmout</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Tax">
      <assert test="empty(oagis:LineNumber)">oagis:Invoice/oagis:Line/oagis:Tax may not contain oagis:LineNumber</assert>
      <assert test="empty(oagis:Tax)">oagis:Invoice/oagis:Line/oagis:Tax may not contain oagis:Tax</assert>
      <assert test="empty(oagis:TaxJurisdiction)">oagis:Invoice/oagis:Line/oagis:Tax may not contain oagis:TaxJurisdiction</assert>
      <assert test="empty(oagis:TaxCode)">oagis:Invoice/oagis:Line/oagis:Tax may not contain oagis:TaxCode</assert>
      <assert test="empty(oagis:Charges)">oagis:Invoice/oagis:Line/oagis:Tax may not contain oagis:Charges</assert>
      <assert test="empty(oagis:Description)">oagis:Invoice/oagis:Line/oagis:Tax may not contain oagis:Description</assert>
      <assert test="empty(oagis:UserArea)">oagis:Invoice/oagis:Line/oagis:Tax may not contain oagis:UserArea</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData">
      <assert test="empty(hrxml:ReferenceInformation)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData may not contain hrxml:ReferenceInformation</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements">
      <assert test="empty(hrxml:ExternalReqNumber)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalReqNumber</assert>
      <assert test="empty(hrxml:Entity)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Entity</assert>
      <assert test="empty(hrxml:CustomerJobDescription)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobDescription</assert>
      <assert test="empty(hrxml:AccountCode)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:AccountCode</assert>
      <assert test="empty(hrxml:SupervisorName)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SupervisorName</assert>
      <assert test="empty(hrxml:SubEntity)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SubEntity</assert>
      <assert test="empty(hrxml:ExternalOrderNumber)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalOrderNumber</assert>
      <assert test="empty(hrxml:LocationName)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationName</assert>
      <assert test="empty(hrxml:ContactName)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ContactName</assert>
      <assert test="empty(hrxml:ManagerName)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ManagerName</assert>
      <assert test="empty(hrxml:LocationCode)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationCode</assert>
      <assert test="empty(hrxml:Shift)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Shift</assert>
      <assert test="empty(hrxml:CustomerJobCode)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobCode</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard">
      <assert test="empty(hrxml:UserArea)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard may not contain hrxml:UserArea</assert>
      <assert test="empty(@lang)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData">
      <assert test="empty(@type)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData may not contain @type</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements">
      <assert test="empty(hrxml:ExternalReqNumber)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalReqNumber</assert>
      <assert test="empty(hrxml:Shift)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Shift</assert>
      <assert test="empty(hrxml:LocationName)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationName</assert>
      <assert test="empty(hrxml:LocationCode)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationCode</assert>
      <assert test="empty(hrxml:Entity)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Entity</assert>
      <assert test="empty(hrxml:ExternalOrderNumber)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalOrderNumber</assert>
      <assert test="empty(hrxml:SubEntity)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SubEntity</assert>
      <assert test="empty(hrxml:AccountCode)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:AccountCode</assert>
      <assert test="empty(hrxml:ContactName)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ContactName</assert>
      <assert test="empty(hrxml:ManagerName)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ManagerName</assert>
      <assert test="empty(hrxml:CustomerJobDescription)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobDescription</assert>
      <assert test="empty(hrxml:CustomerJobCode)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobCode</assert>
      <assert test="empty(hrxml:SupervisorName)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SupervisorName</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation">
      <assert test="empty(hrxml:OrderId)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:OrderId</assert>
      <assert test="empty(hrxml:UserArea)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:UserArea</assert>
      <assert test="empty(hrxml:PositionId)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:PositionId</assert>
      <assert test="empty(hrxml:BillToEntityId)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:BillToEntityId</assert>
      <assert test="empty(hrxml:HumanResourceId)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:HumanResourceId</assert>
      <assert test="empty(hrxml:StaffingOrganizationId)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:StaffingOrganizationId</assert>
      <assert test="empty(hrxml:InvoiceId)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:InvoiceId</assert>
      <assert test="empty(hrxml:MasterOrderId)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:MasterOrderId</assert>
      <assert test="empty(hrxml:IntermediaryId)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:IntermediaryId</assert>
      <assert test="empty(hrxml:DocumentId)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:DocumentId</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId">
      <assert test="empty(@validFrom)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId may not contain @validFrom</assert>
      <assert test="empty(@validTo)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId may not contain @validTo</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId/hrxml:IdValue">
      <assert test="empty(@name)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId">
      <assert test="empty(@validFrom)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may not contain @validFrom</assert>
      <assert test="empty(@validTo)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may not contain @validTo</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/hrxml:IdValue">
      <assert test="empty(@name)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId">
      <assert test="empty(@validFrom)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may not contain @validFrom</assert>
      <assert test="empty(@validTo)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may not contain @validTo</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/hrxml:IdValue">
      <assert test="empty(@name)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId">
      <assert test="empty(@validTo)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may not contain @validTo</assert>
      <assert test="empty(@validFrom)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may not contain @validFrom</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/hrxml:IdValue">
      <assert test="empty(@name)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId">
      <assert test="empty(@validFrom)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId may not contain @validFrom</assert>
      <assert test="empty(@validTo)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId may not contain @validTo</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/hrxml:IdValue">
      <assert test="empty(@name)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo">
      <assert test="empty(@approverType)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo may not contain @approverType</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Comment">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Comment may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id">
      <assert test="empty(@validFrom)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id may not contain @validFrom</assert>
      <assert test="empty(@validTo)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id may not contain @validTo</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id/hrxml:IdValue">
      <assert test="empty(@name)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName">
      <assert test="empty(@script)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName may not contain @script</assert>
      <assert test="empty(hrxml:AlternateScript)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName may not contain hrxml:AlternateScript</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id">
      <assert test="empty(@validFrom)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id may not contain @validFrom</assert>
      <assert test="empty(@validTo)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id may not contain @validTo</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id/hrxml:IdValue">
      <assert test="empty(@name)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource">
      <assert test="empty(hrxml:Resource)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource may not contain hrxml:Resource</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id">
      <assert test="empty(@validTo)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id may not contain @validTo</assert>
      <assert test="empty(@validFrom)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id may not contain @validFrom</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id/hrxml:IdValue">
      <assert test="empty(@name)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName">
      <assert test="empty(@script)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName may not contain @script</assert>
      <assert test="empty(hrxml:AlternateScript)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName may not contain hrxml:AlternateScript</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime">
      <assert test="empty(hrxml:ReportedPersonAssignment)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:ReportedPersonAssignment</assert>
      <assert test="empty(hrxml:Expense)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:Expense</assert>
      <assert test="empty(hrxml:ApprovalInfo)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:ApprovalInfo</assert>
      <assert test="empty(hrxml:AdditionalData)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:AdditionalData</assert>
      <assert test="empty(hrxml:TimeEvent)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:TimeEvent</assert>
      <assert test="empty(hrxml:SubmitterInfo)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:SubmitterInfo</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance">
      <assert test="empty(hrxml:ApprovalInfo)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance may not contain hrxml:ApprovalInfo</assert>
      <assert test="empty(hrxml:SubmitterInfo)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance may not contain hrxml:SubmitterInfo</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData">
      <assert test="empty(@type)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData may not contain @type</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData">
      <assert test="empty(hrxml:ReferenceInformation)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData may not contain hrxml:ReferenceInformation</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements">
      <assert test="empty(hrxml:CustomerJobDescription)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobDescription</assert>
      <assert test="empty(hrxml:ExternalOrderNumber)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalOrderNumber</assert>
      <assert test="empty(hrxml:ExternalReqNumber)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalReqNumber</assert>
      <assert test="empty(hrxml:SupervisorName)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SupervisorName</assert>
      <assert test="empty(hrxml:SubEntity)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SubEntity</assert>
      <assert test="empty(hrxml:LocationCode)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationCode</assert>
      <assert test="empty(hrxml:CustomerJobCode)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobCode</assert>
      <assert test="empty(hrxml:Shift)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Shift</assert>
      <assert test="empty(hrxml:Entity)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Entity</assert>
      <assert test="empty(hrxml:ManagerName)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ManagerName</assert>
      <assert test="empty(hrxml:AccountCode)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:AccountCode</assert>
      <assert test="empty(hrxml:LocationName)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationName</assert>
      <assert test="empty(hrxml:ContactName)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ContactName</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Comment">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Comment may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id">
      <assert test="empty(@validFrom)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id may not contain @validFrom</assert>
      <assert test="empty(@validTo)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id may not contain @validTo</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval">
      <assert test="empty(hrxml:PieceWork)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval may not contain hrxml:PieceWork</assert>
      <assert test="empty(hrxml:Allowance)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval may not contain hrxml:Allowance</assert>
      <assert test="empty(hrxml:SubmitterInfo)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval may not contain hrxml:SubmitterInfo</assert>
      <assert test="empty(hrxml:ApprovalInfo)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval may not contain hrxml:ApprovalInfo</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData">
      <assert test="empty(@type)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData may not contain @type</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData">
      <assert test="empty(hrxml:ReferenceInformation)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData may not contain hrxml:ReferenceInformation</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements">
      <assert test="empty(hrxml:LocationCode)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationCode</assert>
      <assert test="empty(hrxml:CustomerJobCode)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobCode</assert>
      <assert test="empty(hrxml:Entity)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Entity</assert>
      <assert test="empty(hrxml:LocationName)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationName</assert>
      <assert test="empty(hrxml:AccountCode)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:AccountCode</assert>
      <assert test="empty(hrxml:ExternalOrderNumber)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalOrderNumber</assert>
      <assert test="empty(hrxml:ExternalReqNumber)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalReqNumber</assert>
      <assert test="empty(hrxml:Shift)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Shift</assert>
      <assert test="empty(hrxml:SupervisorName)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SupervisorName</assert>
      <assert test="empty(hrxml:SubEntity)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SubEntity</assert>
      <assert test="empty(hrxml:ContactName)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ContactName</assert>
      <assert test="empty(hrxml:ManagerName)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ManagerName</assert>
      <assert test="empty(hrxml:CustomerJobDescription)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobDescription</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Comment">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Comment may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id">
      <assert test="empty(@validFrom)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id may not contain @validFrom</assert>
      <assert test="empty(@validTo)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id may not contain @validTo</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id/hrxml:IdValue">
      <assert test="empty(@name)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount">
      <assert test="empty(@period)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount may not contain @period</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:SubmitterInfo">
      <assert test="empty(hrxml:Person)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:SubmitterInfo may not contain hrxml:Person</assert>
    </rule>
  </pattern>
  <pattern id="cardinality-redefines">
    <rule context="oagis:Invoice">
      <assert test="count(oagis:Header) &gt;= 1">oagis:Invoice must contain oagis:Header at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header">
      <assert test="count(oagis:TotalTax) &gt;= 1">oagis:Invoice/oagis:Header must contain oagis:TotalTax at least 1 time(s)</assert>
      <assert test="count(oagis:TotalAmount) &gt;= 1 and count(oagis:TotalAmount) &lt;= 1">oagis:Invoice/oagis:Header must contain oagis:TotalAmount at least 1 and at most 1 time(s)</assert>
      <assert test="count(oagis:DocumentIds) &gt;= 1">oagis:Invoice/oagis:Header must contain oagis:DocumentIds at least 1 time(s)</assert>
      <assert test="count(oagis:TotalCharges) &gt;= 1">oagis:Invoice/oagis:Header must contain oagis:TotalCharges at least 1 time(s)</assert>
      <assert test="count(oagis:DocumentDateTime) &gt;= 1">oagis:Invoice/oagis:Header must contain oagis:DocumentDateTime at least 1 time(s)</assert>
      <assert test="count(oagis:UserArea) &gt;= 1">oagis:Invoice/oagis:Header must contain oagis:UserArea at least 1 time(s)</assert>
      <assert test="count(oagis:ReasonCode) &gt;= 1">oagis:Invoice/oagis:Header must contain oagis:ReasonCode at least 1 time(s)</assert>
      <assert test="count(oagis:Parties) &gt;= 1">oagis:Invoice/oagis:Header must contain oagis:Parties at least 1 time(s)</assert>
      <assert test="count(oagis:Type) &gt;= 1">oagis:Invoice/oagis:Header must contain oagis:Type at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Attachments/oagis:Attachment">
      <assert test="count(oagis:FileType) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Attachments/oagis:Attachment must contain oagis:FileType at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Charges">
      <assert test="count(oagis:Charge) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Charges may contain oagis:Charge at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Charges/oagis:Charge">
      <assert test="count(oagis:Total) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Charges/oagis:Charge must contain oagis:Total at least 1 time(s)</assert>
      <assert test="count(oagis:Description) &gt;= 1 and count(oagis:Description) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Charges/oagis:Charge must contain oagis:Description at least 1 and at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:DocumentIds">
      <assert test="count(oagis:DocumentId) &gt;= 1 and count(oagis:DocumentId) &lt;= 1">oagis:Invoice/oagis:Header/oagis:DocumentIds must contain oagis:DocumentId at least 1 and at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:DocumentIds/oagis:DocumentId">
      <assert test="count(oagis:Id) &gt;= 1">oagis:Invoice/oagis:Header/oagis:DocumentIds/oagis:DocumentId must contain oagis:Id at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:DocumentReferences">
      <assert test="count(oagis:InvoiceDocumentReference) &lt;= 1">oagis:Invoice/oagis:Header/oagis:DocumentReferences may contain oagis:InvoiceDocumentReference at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference">
      <assert test="count(oagis:DocumentIds) &gt;= 1">oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference must contain oagis:DocumentIds at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds">
      <assert test="count(oagis:DocumentId) &gt;= 1 and count(oagis:DocumentId) &lt;= 1">oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds must contain oagis:DocumentId at least 1 and at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds/oagis:DocumentId">
      <assert test="count(oagis:Id) &gt;= 1">oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds/oagis:DocumentId must contain oagis:Id at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties">
      <assert test="count(oagis:RemitToParty) &gt;= 1 and count(oagis:RemitToParty) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties must contain oagis:RemitToParty at least 1 and at most 1 time(s)</assert>
      <assert test="count(oagis:BillToParty) &gt;= 1 and count(oagis:BillToParty) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties must contain oagis:BillToParty at least 1 and at most 1 time(s)</assert>
      <assert test="count(oagis:CustomerParty) &gt;= 1 and count(oagis:CustomerParty) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties must contain oagis:CustomerParty at least 1 and at most 1 time(s)</assert>
      <assert test="count(oagis:SupplierParty) &gt;= 1 and count(oagis:SupplierParty) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties must contain oagis:SupplierParty at least 1 and at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty">
      <assert test="count(oagis:PartyId) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty must contain oagis:PartyId at least 1 time(s)</assert>
      <assert test="count(oagis:Addresses) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty must contain oagis:Addresses at least 1 time(s)</assert>
      <assert test="count(oagis:Name) &gt;= 1 and count(oagis:Name) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty must contain oagis:Name at least 1 and at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses">
      <assert test="count(oagis:PrimaryAddress) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses must contain oagis:PrimaryAddress at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses/oagis:PrimaryAddress">
      <assert test="count(oagis:URI) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:URI at most 1 time(s)</assert>
      <assert test="count(oagis:AddressLine) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:AddressLine at most 1 time(s)</assert>
      <assert test="count(oagis:EMailAddress) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:EMailAddress at most 1 time(s)</assert>
      <assert test="count(oagis:AddressId) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:AddressId at most 1 time(s)</assert>
      <assert test="count(oagis:FaxNumber) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:FaxNumber at most 1 time(s)</assert>
      <assert test="count(oagis:Description) &gt;= 1 and count(oagis:Description) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses/oagis:PrimaryAddress must contain oagis:Description at least 1 and at most 1 time(s)</assert>
      <assert test="count(oagis:Telephone) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:Telephone at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact">
      <assert test="count(oagis:Description) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact may contain oagis:Description at most 1 time(s)</assert>
      <assert test="count(oagis:Telephone) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact may contain oagis:Telephone at most 1 time(s)</assert>
      <assert test="count(oagis:EMailAddress) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact may contain oagis:EMailAddress at most 1 time(s)</assert>
      <assert test="count(oagis:Fax) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact may contain oagis:Fax at most 1 time(s)</assert>
      <assert test="count(oagis:URI) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact may contain oagis:URI at most 1 time(s)</assert>
      <assert test="count(oagis:Person) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact may contain oagis:Person at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses">
      <assert test="count(oagis:PrimaryAddress) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses must contain oagis:PrimaryAddress at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress">
      <assert test="count(oagis:EMailAddress) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:EMailAddress at most 1 time(s)</assert>
      <assert test="count(oagis:Description) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:Description at most 1 time(s)</assert>
      <assert test="count(oagis:Telephone) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:Telephone at most 1 time(s)</assert>
      <assert test="count(oagis:URI) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:URI at most 1 time(s)</assert>
      <assert test="count(oagis:AddressLine) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:AddressLine at most 1 time(s)</assert>
      <assert test="count(oagis:FaxNumber) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:FaxNumber at most 1 time(s)</assert>
      <assert test="count(oagis:AddressId) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:AddressId at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person">
      <assert test="count(oagis:PersonName) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person must contain oagis:PersonName at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName">
      <assert test="count(oagis:MiddleName) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:MiddleName at most 1 time(s)</assert>
      <assert test="count(oagis:Salutation) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:Salutation at most 1 time(s)</assert>
      <assert test="count(oagis:Suffix) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:Suffix at most 1 time(s)</assert>
      <assert test="count(oagis:FormattedName) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:FormattedName at most 1 time(s)</assert>
      <assert test="count(oagis:PreferredGivenName) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:PreferredGivenName at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:PartyId">
      <assert test="count(oagis:Id) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:PartyId must contain oagis:Id at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty">
      <assert test="count(oagis:Addresses) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty must contain oagis:Addresses at least 1 time(s)</assert>
      <assert test="count(oagis:PartyId) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty must contain oagis:PartyId at least 1 time(s)</assert>
      <assert test="count(oagis:Name) &gt;= 1 and count(oagis:Name) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty must contain oagis:Name at least 1 and at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses">
      <assert test="count(oagis:PrimaryAddress) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses must contain oagis:PrimaryAddress at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses/oagis:PrimaryAddress">
      <assert test="count(oagis:Telephone) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:Telephone at most 1 time(s)</assert>
      <assert test="count(oagis:AddressLine) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:AddressLine at most 1 time(s)</assert>
      <assert test="count(oagis:URI) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:URI at most 1 time(s)</assert>
      <assert test="count(oagis:Description) &gt;= 1 and count(oagis:Description) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses/oagis:PrimaryAddress must contain oagis:Description at least 1 and at most 1 time(s)</assert>
      <assert test="count(oagis:FaxNumber) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:FaxNumber at most 1 time(s)</assert>
      <assert test="count(oagis:EMailAddress) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:EMailAddress at most 1 time(s)</assert>
      <assert test="count(oagis:AddressId) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:AddressId at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact">
      <assert test="count(oagis:Fax) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact may contain oagis:Fax at most 1 time(s)</assert>
      <assert test="count(oagis:Telephone) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact may contain oagis:Telephone at most 1 time(s)</assert>
      <assert test="count(oagis:EMailAddress) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact may contain oagis:EMailAddress at most 1 time(s)</assert>
      <assert test="count(oagis:Description) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact may contain oagis:Description at most 1 time(s)</assert>
      <assert test="count(oagis:URI) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact may contain oagis:URI at most 1 time(s)</assert>
      <assert test="count(oagis:Person) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact may contain oagis:Person at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses">
      <assert test="count(oagis:PrimaryAddress) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses must contain oagis:PrimaryAddress at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress">
      <assert test="count(oagis:URI) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:URI at most 1 time(s)</assert>
      <assert test="count(oagis:EMailAddress) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:EMailAddress at most 1 time(s)</assert>
      <assert test="count(oagis:FaxNumber) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:FaxNumber at most 1 time(s)</assert>
      <assert test="count(oagis:Description) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:Description at most 1 time(s)</assert>
      <assert test="count(oagis:AddressId) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:AddressId at most 1 time(s)</assert>
      <assert test="count(oagis:AddressLine) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:AddressLine at most 1 time(s)</assert>
      <assert test="count(oagis:Telephone) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:Telephone at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person">
      <assert test="count(oagis:PersonName) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person must contain oagis:PersonName at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName">
      <assert test="count(oagis:Suffix) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:Suffix at most 1 time(s)</assert>
      <assert test="count(oagis:PreferredGivenName) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:PreferredGivenName at most 1 time(s)</assert>
      <assert test="count(oagis:Salutation) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:Salutation at most 1 time(s)</assert>
      <assert test="count(oagis:FormattedName) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:FormattedName at most 1 time(s)</assert>
      <assert test="count(oagis:MiddleName) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:MiddleName at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:PartyId">
      <assert test="count(oagis:Id) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:PartyId must contain oagis:Id at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty">
      <assert test="count(oagis:Name) &gt;= 1 and count(oagis:Name) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty must contain oagis:Name at least 1 and at most 1 time(s)</assert>
      <assert test="count(oagis:Addresses) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty must contain oagis:Addresses at least 1 time(s)</assert>
      <assert test="count(oagis:PartyId) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty must contain oagis:PartyId at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses">
      <assert test="count(oagis:PrimaryAddress) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses must contain oagis:PrimaryAddress at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses/oagis:PrimaryAddress">
      <assert test="count(oagis:Telephone) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:Telephone at most 1 time(s)</assert>
      <assert test="count(oagis:Description) &gt;= 1 and count(oagis:Description) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses/oagis:PrimaryAddress must contain oagis:Description at least 1 and at most 1 time(s)</assert>
      <assert test="count(oagis:URI) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:URI at most 1 time(s)</assert>
      <assert test="count(oagis:EMailAddress) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:EMailAddress at most 1 time(s)</assert>
      <assert test="count(oagis:AddressId) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:AddressId at most 1 time(s)</assert>
      <assert test="count(oagis:AddressLine) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:AddressLine at most 1 time(s)</assert>
      <assert test="count(oagis:FaxNumber) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:FaxNumber at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact">
      <assert test="count(oagis:URI) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact may contain oagis:URI at most 1 time(s)</assert>
      <assert test="count(oagis:Person) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact may contain oagis:Person at most 1 time(s)</assert>
      <assert test="count(oagis:Description) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact may contain oagis:Description at most 1 time(s)</assert>
      <assert test="count(oagis:Telephone) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact may contain oagis:Telephone at most 1 time(s)</assert>
      <assert test="count(oagis:EMailAddress) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact may contain oagis:EMailAddress at most 1 time(s)</assert>
      <assert test="count(oagis:Fax) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact may contain oagis:Fax at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses">
      <assert test="count(oagis:PrimaryAddress) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses must contain oagis:PrimaryAddress at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress">
      <assert test="count(oagis:Telephone) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:Telephone at most 1 time(s)</assert>
      <assert test="count(oagis:URI) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:URI at most 1 time(s)</assert>
      <assert test="count(oagis:EMailAddress) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:EMailAddress at most 1 time(s)</assert>
      <assert test="count(oagis:AddressLine) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:AddressLine at most 1 time(s)</assert>
      <assert test="count(oagis:AddressId) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:AddressId at most 1 time(s)</assert>
      <assert test="count(oagis:Description) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:Description at most 1 time(s)</assert>
      <assert test="count(oagis:FaxNumber) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:FaxNumber at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person">
      <assert test="count(oagis:PersonName) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person must contain oagis:PersonName at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName">
      <assert test="count(oagis:PreferredGivenName) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:PreferredGivenName at most 1 time(s)</assert>
      <assert test="count(oagis:Suffix) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:Suffix at most 1 time(s)</assert>
      <assert test="count(oagis:MiddleName) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:MiddleName at most 1 time(s)</assert>
      <assert test="count(oagis:Salutation) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:Salutation at most 1 time(s)</assert>
      <assert test="count(oagis:FormattedName) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:FormattedName at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:PartyId">
      <assert test="count(oagis:Id) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:PartyId must contain oagis:Id at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty">
      <assert test="count(oagis:Addresses) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty must contain oagis:Addresses at least 1 time(s)</assert>
      <assert test="count(oagis:PartyId) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty must contain oagis:PartyId at least 1 time(s)</assert>
      <assert test="count(oagis:Name) &gt;= 1 and count(oagis:Name) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty must contain oagis:Name at least 1 and at most 1 time(s)</assert>
      <assert test="count(oagis:TaxId) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty must contain oagis:TaxId at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses">
      <assert test="count(oagis:PrimaryAddress) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses must contain oagis:PrimaryAddress at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses/oagis:PrimaryAddress">
      <assert test="count(oagis:Description) &gt;= 1 and count(oagis:Description) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses/oagis:PrimaryAddress must contain oagis:Description at least 1 and at most 1 time(s)</assert>
      <assert test="count(oagis:EMailAddress) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:EMailAddress at most 1 time(s)</assert>
      <assert test="count(oagis:FaxNumber) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:FaxNumber at most 1 time(s)</assert>
      <assert test="count(oagis:Telephone) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:Telephone at most 1 time(s)</assert>
      <assert test="count(oagis:AddressId) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:AddressId at most 1 time(s)</assert>
      <assert test="count(oagis:AddressLine) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:AddressLine at most 1 time(s)</assert>
      <assert test="count(oagis:URI) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:URI at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact">
      <assert test="count(oagis:Fax) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact may contain oagis:Fax at most 1 time(s)</assert>
      <assert test="count(oagis:Person) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact may contain oagis:Person at most 1 time(s)</assert>
      <assert test="count(oagis:EMailAddress) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact may contain oagis:EMailAddress at most 1 time(s)</assert>
      <assert test="count(oagis:Description) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact may contain oagis:Description at most 1 time(s)</assert>
      <assert test="count(oagis:Telephone) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact may contain oagis:Telephone at most 1 time(s)</assert>
      <assert test="count(oagis:URI) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact may contain oagis:URI at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses">
      <assert test="count(oagis:PrimaryAddress) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses must contain oagis:PrimaryAddress at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress">
      <assert test="count(oagis:AddressLine) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:AddressLine at most 1 time(s)</assert>
      <assert test="count(oagis:AddressId) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:AddressId at most 1 time(s)</assert>
      <assert test="count(oagis:Description) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:Description at most 1 time(s)</assert>
      <assert test="count(oagis:EMailAddress) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:EMailAddress at most 1 time(s)</assert>
      <assert test="count(oagis:FaxNumber) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:FaxNumber at most 1 time(s)</assert>
      <assert test="count(oagis:URI) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:URI at most 1 time(s)</assert>
      <assert test="count(oagis:Telephone) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:Telephone at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person">
      <assert test="count(oagis:PersonName) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person must contain oagis:PersonName at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName">
      <assert test="count(oagis:Suffix) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:Suffix at most 1 time(s)</assert>
      <assert test="count(oagis:FormattedName) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:FormattedName at most 1 time(s)</assert>
      <assert test="count(oagis:MiddleName) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:MiddleName at most 1 time(s)</assert>
      <assert test="count(oagis:PreferredGivenName) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:PreferredGivenName at most 1 time(s)</assert>
      <assert test="count(oagis:Salutation) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:Salutation at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:PartyId">
      <assert test="count(oagis:Id) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:PartyId must contain oagis:Id at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Tax">
      <assert test="count(oagis:TaxAmount) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Tax must contain oagis:TaxAmount at least 1 time(s)</assert>
      <assert test="count(oagis:TaxBaseAmount) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Tax must contain oagis:TaxBaseAmount at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea">
      <assert test="count(hrxml:StaffingAdditionalData) &gt;= 1 and count(hrxml:StaffingAdditionalData) &lt;= 1">oagis:Invoice/oagis:Header/oagis:UserArea must contain hrxml:StaffingAdditionalData at least 1 and at most 1 time(s)</assert>
      <assert test="count(hrxml:StaffingOrganizationNL) &gt;= 1 and count(hrxml:StaffingOrganizationNL) &lt;= 1">oagis:Invoice/oagis:Header/oagis:UserArea must contain hrxml:StaffingOrganizationNL at least 1 and at most 1 time(s)</assert>
      <assert test="count(hrxml:StaffingOrganization) &lt;= 1">oagis:Invoice/oagis:Header/oagis:UserArea may contain hrxml:StaffingOrganization at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData">
      <assert test="count(hrxml:CustomerReportingRequirements) &gt;= 1">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData must contain hrxml:CustomerReportingRequirements at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements">
      <assert test="count(hrxml:AdditionalRequirement) &gt;= 1">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements must contain hrxml:AdditionalRequirement at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement">
      <assert test="count(@requirementTitle) &gt;= 1">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must contain @requirementTitle at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation">
      <assert test="count(hrxml:StaffingSupplierId) &lt;= 1">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may contain hrxml:StaffingSupplierId at most 1 time(s)</assert>
      <assert test="count(hrxml:StaffingCustomerId) &lt;= 1">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may contain hrxml:StaffingCustomerId at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId">
      <assert test="count(hrxml:IdValue) &lt;= 1">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId may contain hrxml:IdValue at most 1 time(s)</assert>
      <assert test="count(@idOwner) &gt;= 1">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId must contain @idOwner at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId">
      <assert test="count(hrxml:IdValue) &lt;= 1">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may contain hrxml:IdValue at most 1 time(s)</assert>
      <assert test="count(@idOwner) &gt;= 1">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId must contain @idOwner at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId">
      <assert test="count(@idOwner) &gt;= 1">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId must contain @idOwner at least 1 time(s)</assert>
      <assert test="count(hrxml:IdValue) &lt;= 1">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId">
      <assert test="count(hrxml:IdValue) &lt;= 1">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may contain hrxml:IdValue at most 1 time(s)</assert>
      <assert test="count(@idOwner) &gt;= 1">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId must contain @idOwner at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId">
      <assert test="count(hrxml:IdValue) &lt;= 1">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId may contain hrxml:IdValue at most 1 time(s)</assert>
      <assert test="count(@idOwner) &gt;= 1">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId must contain @idOwner at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization">
      <assert test="count(hrxml:PaymentInfo) &gt;= 1">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization must contain hrxml:PaymentInfo at least 1 time(s)</assert>
      <assert test="count(hrxml:Organization) &lt;= 1">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization may contain hrxml:Organization at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization">
      <assert test="count(hrxml:OrganizationName) &gt;= 1">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization must contain hrxml:OrganizationName at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo">
      <assert test="count(hrxml:BankAccountInfo) &gt;= 1">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo must contain hrxml:BankAccountInfo at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo/hrxml:BankAccountInfo">
      <assert test="count(hrxml:BankInfoByJurisdiction) &gt;= 1 and count(hrxml:BankInfoByJurisdiction) &lt;= 2">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo/hrxml:BankAccountInfo must contain hrxml:BankInfoByJurisdiction at least 1 and at most 2 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganizationNL">
      <assert test="count(hrxml:ChamberofCommerceReference) &gt;= 1">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganizationNL must contain hrxml:ChamberofCommerceReference at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line">
      <assert test="count(oagis:Charges) &gt;= 1">oagis:Invoice/oagis:Line must contain oagis:Charges at least 1 time(s)</assert>
      <assert test="count(oagis:LineNumber) &gt;= 1">oagis:Invoice/oagis:Line must contain oagis:LineNumber at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Charges">
      <assert test="count(oagis:TotalCharge) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Charges must contain oagis:TotalCharge at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Charges/oagis:TotalCharge">
      <assert test="count(oagis:Total) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Charges/oagis:TotalCharge must contain oagis:Total at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:DocumentReferences">
      <assert test="count(oagis:InvoiceDocumentReference) &lt;= 1">oagis:Invoice/oagis:Line/oagis:DocumentReferences may contain oagis:InvoiceDocumentReference at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference">
      <assert test="count(oagis:DocumentIds) &gt;= 1">oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference must contain oagis:DocumentIds at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds">
      <assert test="count(oagis:DocumentId) &gt;= 1 and count(oagis:DocumentId) &lt;= 1">oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds must contain oagis:DocumentId at least 1 and at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds/oagis:DocumentId">
      <assert test="count(oagis:Id) &gt;= 1">oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds/oagis:DocumentId must contain oagis:Id at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line">
      <assert test="count(oagis:LineNumber) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Line must contain oagis:LineNumber at least 1 time(s)</assert>
      <assert test="count(oagis:Charges) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Line must contain oagis:Charges at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges">
      <assert test="count(oagis:TotalCharge) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges must contain oagis:TotalCharge at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges/oagis:TotalCharge">
      <assert test="count(oagis:Total) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges/oagis:TotalCharge must contain oagis:Total at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences">
      <assert test="count(oagis:InvoiceDocumentReference) &lt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences may contain oagis:InvoiceDocumentReference at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference">
      <assert test="count(oagis:DocumentIds) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference must contain oagis:DocumentIds at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds">
      <assert test="count(oagis:DocumentId) &gt;= 1 and count(oagis:DocumentId) &lt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds must contain oagis:DocumentId at least 1 and at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds/oagis:DocumentId">
      <assert test="count(oagis:Id) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds/oagis:DocumentId must contain oagis:Id at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:Tax">
      <assert test="count(oagis:TaxBaseAmount) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:Tax must contain oagis:TaxBaseAmount at least 1 time(s)</assert>
      <assert test="count(oagis:TaxAmount) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:Tax must contain oagis:TaxAmount at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea">
      <assert test="count(hrxml:StaffingAdditionalData) &lt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea may contain hrxml:StaffingAdditionalData at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement">
      <assert test="count(@requirementTitle) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must contain @requirementTitle at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard">
      <assert test="count(hrxml:AdditionalData) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard must contain hrxml:AdditionalData at least 1 time(s)</assert>
      <assert test="count(hrxml:Id) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard must contain hrxml:Id at least 1 time(s)</assert>
      <assert test="count(hrxml:ReportedTime) &lt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard may contain hrxml:ReportedTime at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData">
      <assert test="count(hrxml:StaffingAdditionalData) &gt;= 1 and count(hrxml:StaffingAdditionalData) &lt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData must contain hrxml:StaffingAdditionalData at least 1 and at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId">
      <assert test="count(hrxml:IdValue) &lt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId may contain hrxml:IdValue at most 1 time(s)</assert>
      <assert test="count(@idOwner) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId must contain @idOwner at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId">
      <assert test="count(hrxml:IdValue) &lt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may contain hrxml:IdValue at most 1 time(s)</assert>
      <assert test="count(@idOwner) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId must contain @idOwner at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId">
      <assert test="count(hrxml:IdValue) &lt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may contain hrxml:IdValue at most 1 time(s)</assert>
      <assert test="count(@idOwner) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId must contain @idOwner at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId">
      <assert test="count(@idOwner) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId must contain @idOwner at least 1 time(s)</assert>
      <assert test="count(hrxml:IdValue) &lt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId">
      <assert test="count(@idOwner) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId must contain @idOwner at least 1 time(s)</assert>
      <assert test="count(hrxml:IdValue) &lt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id">
      <assert test="count(hrxml:IdValue) &lt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</assert>
      <assert test="count(@idOwner) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id must contain @idOwner at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName">
      <assert test="count(hrxml:FamilyName) &lt;= 2">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName may contain hrxml:FamilyName at most 2 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id">
      <assert test="count(hrxml:IdValue) &lt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</assert>
      <assert test="count(@idOwner) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id must contain @idOwner at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource">
      <assert test="count(hrxml:Person) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource must contain hrxml:Person at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id">
      <assert test="count(hrxml:IdValue) &lt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</assert>
      <assert test="count(@idOwner) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id must contain @idOwner at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName">
      <assert test="count(hrxml:FamilyName) &lt;= 2">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName may contain hrxml:FamilyName at most 2 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance">
      <assert test="count(hrxml:Amount) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance must contain hrxml:Amount at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData">
      <assert test="count(hrxml:StaffingAdditionalData) &lt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData may contain hrxml:StaffingAdditionalData at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement">
      <assert test="count(@requirementTitle) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must contain @requirementTitle at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id">
      <assert test="count(@idOwner) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id must contain @idOwner at least 1 time(s)</assert>
      <assert test="count(hrxml:IdValue) &lt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue">
      <assert test="count(@name) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue must contain @name at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements">
      <assert test="count(hrxml:AdditionalRequirement) &lt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may contain hrxml:AdditionalRequirement at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement">
      <assert test="count(@requirementTitle) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must contain @requirementTitle at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id">
      <assert test="count(hrxml:IdValue) &lt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</assert>
      <assert test="count(@idOwner) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id must contain @idOwner at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount">
      <assert test="count(@multiplier) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount must contain @multiplier at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Tax">
      <assert test="count(oagis:TaxAmount) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Tax must contain oagis:TaxAmount at least 1 time(s)</assert>
      <assert test="count(oagis:TaxBaseAmount) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Tax must contain oagis:TaxBaseAmount at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea">
      <assert test="count(hrxml:StaffingAdditionalData) &lt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea may contain hrxml:StaffingAdditionalData at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement">
      <assert test="count(@requirementTitle) &gt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must contain @requirementTitle at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard">
      <assert test="count(hrxml:ReportedTime) &lt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard may contain hrxml:ReportedTime at most 1 time(s)</assert>
      <assert test="count(hrxml:AdditionalData) &gt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard must contain hrxml:AdditionalData at least 1 time(s)</assert>
      <assert test="count(hrxml:Id) &gt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard must contain hrxml:Id at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData">
      <assert test="count(hrxml:StaffingAdditionalData) &gt;= 1 and count(hrxml:StaffingAdditionalData) &lt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData must contain hrxml:StaffingAdditionalData at least 1 and at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId">
      <assert test="count(hrxml:IdValue) &lt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId may contain hrxml:IdValue at most 1 time(s)</assert>
      <assert test="count(@idOwner) &gt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId must contain @idOwner at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId">
      <assert test="count(hrxml:IdValue) &lt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may contain hrxml:IdValue at most 1 time(s)</assert>
      <assert test="count(@idOwner) &gt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId must contain @idOwner at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId">
      <assert test="count(hrxml:IdValue) &lt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may contain hrxml:IdValue at most 1 time(s)</assert>
      <assert test="count(@idOwner) &gt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId must contain @idOwner at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId">
      <assert test="count(hrxml:IdValue) &lt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may contain hrxml:IdValue at most 1 time(s)</assert>
      <assert test="count(@idOwner) &gt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId must contain @idOwner at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId">
      <assert test="count(hrxml:IdValue) &lt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId may contain hrxml:IdValue at most 1 time(s)</assert>
      <assert test="count(@idOwner) &gt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId must contain @idOwner at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id">
      <assert test="count(hrxml:IdValue) &lt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</assert>
      <assert test="count(@idOwner) &gt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id must contain @idOwner at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName">
      <assert test="count(hrxml:FamilyName) &lt;= 2">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName may contain hrxml:FamilyName at most 2 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id">
      <assert test="count(@idOwner) &gt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id must contain @idOwner at least 1 time(s)</assert>
      <assert test="count(hrxml:IdValue) &lt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource">
      <assert test="count(hrxml:Person) &gt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource must contain hrxml:Person at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id">
      <assert test="count(hrxml:IdValue) &lt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</assert>
      <assert test="count(@idOwner) &gt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id must contain @idOwner at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName">
      <assert test="count(hrxml:FamilyName) &lt;= 2">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName may contain hrxml:FamilyName at most 2 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance">
      <assert test="count(hrxml:Amount) &gt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance must contain hrxml:Amount at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData">
      <assert test="count(hrxml:StaffingAdditionalData) &lt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData may contain hrxml:StaffingAdditionalData at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement">
      <assert test="count(@requirementTitle) &gt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must contain @requirementTitle at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id">
      <assert test="count(hrxml:IdValue) &lt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</assert>
      <assert test="count(@idOwner) &gt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id must contain @idOwner at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue">
      <assert test="count(@name) &gt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue must contain @name at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements">
      <assert test="count(hrxml:AdditionalRequirement) &lt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may contain hrxml:AdditionalRequirement at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement">
      <assert test="count(@requirementTitle) &gt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must contain @requirementTitle at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id">
      <assert test="count(@idOwner) &gt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id must contain @idOwner at least 1 time(s)</assert>
      <assert test="count(hrxml:IdValue) &lt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount">
      <assert test="count(@multiplier) &gt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount must contain @multiplier at least 1 time(s)</assert>
    </rule>
  </pattern>
  <pattern id="type-restrictions">
    <rule context="oagis:Invoice">
      <assert test="count(oagis:Line/oagis:LineNumber) = count(distinct-values(oagis:Line/oagis:LineNumber))">LineNumbers must be unique</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header">
      <assert test="empty(oagis:ReasonCode) or (oagis:ReasonCode='services') or (oagis:ReasonCode='hours') or (oagis:ReasonCode='combination')">oagis:Invoice/oagis:Header/oagis:ReasonCode must have one of the following values: [services, hours, combination]</assert>
      <assert test="empty(oagis:Type) or (oagis:Type='Debit') or (oagis:Type='Credit') or (oagis:Type='Both')">oagis:Invoice/oagis:Header/oagis:Type must have one of the following values: [Debit, Credit, Both]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Attachments/oagis:Attachment">
      <assert test="empty(oagis:FileType) or (oagis:FileType='application/pdf')">oagis:Invoice/oagis:Header/oagis:Attachments/oagis:Attachment/oagis:FileType must have one of the following values: [application/pdf]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Attachments/oagis:Attachment/oagis:EmbeddedData">
      <assert test="empty(@encoding) or (@encoding='base64')">oagis:Invoice/oagis:Header/oagis:Attachments/oagis:Attachment/oagis:EmbeddedData/@encoding must have one of the following values: [base64]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Charges/oagis:Charge">
      <assert test="empty(oagis:Description) or (oagis:Description='TotalOnChargedVAT')">oagis:Invoice/oagis:Header/oagis:Charges/oagis:Charge/oagis:Description must have one of the following values: [TotalOnChargedVAT]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses/oagis:PrimaryAddress">
      <assert test="empty(oagis:Description) or (oagis:Description='PhysicalAddress') or (oagis:Description='PostalAddress')">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses/oagis:PrimaryAddress/oagis:Description must have one of the following values: [PhysicalAddress, PostalAddress]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress">
      <assert test="empty(oagis:Description) or (oagis:Description='PhysicalAddress') or (oagis:Description='PostalAddress')">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:Description must have one of the following values: [PhysicalAddress, PostalAddress]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses/oagis:PrimaryAddress">
      <assert test="empty(oagis:Description) or (oagis:Description='PhysicalAddress') or (oagis:Description='PostalAddress')">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses/oagis:PrimaryAddress/oagis:Description must have one of the following values: [PhysicalAddress, PostalAddress]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress">
      <assert test="empty(oagis:Description) or (oagis:Description='PhysicalAddress') or (oagis:Description='PostalAddress')">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:Description must have one of the following values: [PhysicalAddress, PostalAddress]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses/oagis:PrimaryAddress">
      <assert test="empty(oagis:Description) or (oagis:Description='PhysicalAddress') or (oagis:Description='PostalAddress')">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses/oagis:PrimaryAddress/oagis:Description must have one of the following values: [PhysicalAddress, PostalAddress]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress">
      <assert test="empty(oagis:Description) or (oagis:Description='PhysicalAddress') or (oagis:Description='PostalAddress')">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:Description must have one of the following values: [PhysicalAddress, PostalAddress]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses/oagis:PrimaryAddress">
      <assert test="empty(oagis:Description) or (oagis:Description='PhysicalAddress') or (oagis:Description='PostalAddress')">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses/oagis:PrimaryAddress/oagis:Description must have one of the following values: [PhysicalAddress, PostalAddress]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress">
      <assert test="empty(oagis:Description) or (oagis:Description='PhysicalAddress') or (oagis:Description='PostalAddress')">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:Description must have one of the following values: [PhysicalAddress, PostalAddress]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:PaymentTerms/oagis:DayOfMonth">
      <assert test="number(text()) &gt; 0">oagis:Invoice/oagis:Header/oagis:PaymentTerms/oagis:DayOfMonth must be at least 1.</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:PaymentTerms/oagis:DiscountPercent">
      <assert test="empty(@uom) or (@uom='percentage')">oagis:Invoice/oagis:Header/oagis:PaymentTerms/oagis:DiscountPercent/@uom must have one of the following values: [percentage]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:PaymentTerms/oagis:NumberOfDays">
      <assert test="number(text()) &gt; 0">oagis:Invoice/oagis:Header/oagis:PaymentTerms/oagis:NumberOfDays must be at least 1.</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Tax/oagis:PercentQuantity">
      <assert test="empty(@uom) or (@uom='BTW')">oagis:Invoice/oagis:Header/oagis:Tax/oagis:PercentQuantity/@uom must have one of the following values: [BTW]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData">
      <assert test="count(hrxml:CustomerReportingRequirements) + count(hrxml:ReferenceInformation) &gt; 0">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData must contain CustomerReportingRequirements or ReferenceInformation</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements">
      <assert test="count(hrxml:AdditionalRequirement[@requirementTitle = 'VersionId']) = 1">There MUST be one CustomerReportingRequirements/AdditionalRequirement with @requirementTitle equal to VersionId</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCompany')">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId/@idOwner must have one of the following values: [StaffingCompany]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='KvK') or (@idOwner='OIN') or (@idOwner='BTW') or (@idOwner='Fi')">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, KvK, OIN, BTW, Fi]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='KvK') or (@idOwner='OIN') or (@idOwner='BTW') or (@idOwner='Fi')">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, KvK, OIN, BTW, Fi]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='KvK') or (@idOwner='OIN') or (@idOwner='BTW') or (@idOwner='Fi')">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, KvK, OIN, BTW, Fi]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='KvK') or (@idOwner='OIN') or (@idOwner='BTW') or (@idOwner='Fi')">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, KvK, OIN, BTW, Fi]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization">
      <assert test="empty(@typeOfOrganization) or (@typeOfOrganization='Supplier')">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/@typeOfOrganization must have one of the following values: [Supplier]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo/hrxml:BankAccountInfo/hrxml:BankInfoByJurisdiction">
      <assert test="matches(hrxml:BankAccountNumber, '^[A-Z0-9]+$')">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo/hrxml:BankAccountInfo/hrxml:BankInfoByJurisdiction/hrxml:BankAccountNumber must match regular expression: ^[A-Z0-9]+$</assert>
      <assert test="empty(@bankJurisdiction) or (@bankJurisdiction='NL')">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo/hrxml:BankAccountInfo/hrxml:BankInfoByJurisdiction/@bankJurisdiction must have one of the following values: [NL]</assert>
      <assert test="(empty(hrxml:BankAccountType) or (hrxml:BankAccountType='IBAN')) or (empty(hrxml:BankAccountType) or (hrxml:BankAccountType=''))">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo/hrxml:BankAccountInfo/hrxml:BankInfoByJurisdiction/hrxml:BankAccountType must have one of the following values: [IBAN] OR oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo/hrxml:BankAccountInfo/hrxml:BankInfoByJurisdiction/hrxml:BankAccountType must be Empty</assert>
      <assert test="empty(hrxml:BankAccountKey) or (hrxml:BankAccountKey='')">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo/hrxml:BankAccountInfo/hrxml:BankInfoByJurisdiction/hrxml:BankAccountKey must be Empty</assert>
      <assert test="empty(hrxml:BankWindow) or (hrxml:BankWindow='')">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo/hrxml:BankAccountInfo/hrxml:BankInfoByJurisdiction/hrxml:BankWindow must be Empty</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo/hrxml:FinancialGuarantee">
      <assert test="empty(hrxml:Name) or (hrxml:Name='G-account') or (hrxml:Name='Depot-account') or (hrxml:Name='Pawning-account')">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo/hrxml:FinancialGuarantee/hrxml:Name must have one of the following values: [G-account, Depot-account, Pawning-account]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line">
      <assert test="count(oagis:Line/oagis:LineNumber) = count(distinct-values(oagis:Line/oagis:LineNumber))">LineNumbers must be unique</assert>
      <assert test="count(oagis:Description) + count(oagis:ReasonCode) + count(oagis:UserArea/hrxml:TimeCard) &gt; 0">Line must have at least one of Description, ReasonCode or TimeCard</assert>
      <assert test="((count(oagis:Price) = 0) and (count(oagis:Line/oagis:Price) = count(oagis:Line))) or ((count(oagis:Price) > 0) and (count(oagis:Line/oagis:Price) = 0))">Price MOET OF op Line niveau OF voor alle Line/Lines worden opgegeven.</assert>
      <assert test="((count(oagis:ItemQuantity) = 0) and (count(oagis:Line/oagis:ItemQuantity) = count(oagis:Line))) or ((count(oagis:ItemQuantity) > 0) and (count(oagis:Line/oagis:ItemQuantity) = 0))">ItemQuantity MOET OF op Line niveau OF voor alle Line/Lines worden opgegeven.</assert>
      <assert test="((count(oagis:ReasonCode) = 0) and (count(oagis:Line/oagis:ReasonCode) = count(oagis:Line))) or ((count(oagis:ReasonCode) > 0) and (count(oagis:Line/oagis:ReasonCode) = 0))">ReasonCode MOET OF op Line niveau OF voor alle Line/Lines worden opgegeven.</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line">
      <assert test="count(oagis:Description) + count(oagis:ReasonCode) + count(oagis:UserArea/hrxml:TimeCard) &gt; 0">Line/Line must have at least one of Description, ReasonCode or TimeCard</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:Price/oagis:PerQuantity">
      <assert test="number(text()) &gt; 0">oagis:Invoice/oagis:Line/oagis:Line/oagis:Price/oagis:PerQuantity must be at least 1.</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:Tax/oagis:PercentQuantity">
      <assert test="exists(index-of(/oagis:Invoice/oagis:Header/oagis:Tax/oagis:PercentQuantity, text()))">Invoice/Line/Line/Tax/PercentQuantity must be available on Header level: <value-of select="text()"/></assert>
      <assert test="empty(@uom) or (@uom='BTW')">oagis:Invoice/oagis:Line/oagis:Line/oagis:Tax/oagis:PercentQuantity/@uom must have one of the following values: [BTW]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard">
      <assert test="count(../../oagis:ItemQuantity) = 1">ItemQuantity must be present when a TimeCard is present on Line/Line.</assert>
      <assert test="(count(hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId) + count(hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:PurchaseOrderNumber)) &gt;= 1">There must be at least one AssignmentId or PurchaseOrderNumber on header level.</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData">
      <assert test="count(hrxml:CustomerReportingRequirements) + count(hrxml:ReferenceInformation) &gt; 0">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData must contain CustomerReportingRequirements or ReferenceInformation</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation">
      <assert test="count(hrxml:StaffingSupplierId/@idOwner) = count(distinct-values(hrxml:StaffingSupplierId/@idOwner))">The same idOwner may not be given for StaffingSupplierId</assert>
      <assert test="count(hrxml:StaffingCustomerId/@idOwner) = count(distinct-values(hrxml:StaffingCustomerId/@idOwner))">The same idOwner may not be given for StaffingCustomerId</assert>
      <assert test="count(hrxml:StaffingCustomerOrgUnitId/@idOwner) = count(distinct-values(hrxml:StaffingCustomerOrgUnitId/@idOwner))">The same idOwner may not be given for StaffingCustomerOrgUnitId</assert>
      <assert test="if (count(hrxml:StaffingCustomerOrgUnitId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingCustomerOrgUnitId[@idOwner = 'KvK']) = 1) else ('true')">If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.</assert>
      <assert test="if (count(hrxml:StaffingCustomerId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingCustomerId[@idOwner = 'KvK']) = 1) else ('true')">If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.</assert>
      <assert test="if (count(hrxml:StaffingSupplierId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingSupplierId[@idOwner = 'KvK']) = 1) else ('true')">If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCompany')">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId/@idOwner must have one of the following values: [StaffingCompany]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId">
      <assert test="string-length() > 0">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId must be filled</assert>
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, OIN, KvK, BTW, Fi, Vest]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId">
      <assert test="string-length() > 0">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId must be filled</assert>
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, OIN, KvK, BTW, Fi, Vest]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId">
      <assert test="string-length() > 0">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId must be filled</assert>
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, OIN, KvK, BTW, Fi, Vest]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='KvK') or (@idOwner='OIN') or (@idOwner='BTW') or (@idOwner='Fi')">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, KvK, OIN, BTW, Fi]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName/hrxml:Affix">
      <assert test="empty(@type) or (@type='aristocraticTitle') or (@type='formOfAddress') or (@type='generation') or (@type='qualification')">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName/hrxml:Affix/@type must have one of the following values: [aristocraticTitle, formOfAddress, generation, qualification]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName/hrxml:FamilyName">
      <assert test="empty(@primary) or (@primary='true') or (@primary='false')">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName/hrxml:FamilyName/@primary must have one of the following values: [true, false]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName/hrxml:Affix">
      <assert test="empty(@type) or (@type='aristocraticTitle') or (@type='formOfAddress') or (@type='generation') or (@type='qualification')">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName/hrxml:Affix/@type must have one of the following values: [aristocraticTitle, formOfAddress, generation, qualification]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName/hrxml:FamilyName">
      <assert test="empty(@primary) or (@primary='true') or (@primary='false')">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName/hrxml:FamilyName/@primary must have one of the following values: [true, false]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime">
      <assert test="count(hrxml:TimeInterval) + count(hrxml:Allowance) &gt; 0">hrxml:TimeCard/hrxml:ReportedTime must contain at least one TimeInterval or Allowance</assert>
      <assert test="(empty(@status) or (@status='rejected') or (@status='corrected')) or (empty(@status) or (@status=''))">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/@status must have one of the following values: [rejected, corrected] OR oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/@status must be Empty</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance">
      <assert test="empty(@actionCode) or (@actionCode='Add') or (@actionCode='Change') or (@actionCode='Void') or (@actionCode='Unchanged')">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/@actionCode must have one of the following values: [Add, Change, Void, Unchanged]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue">
      <assert test="empty(@name) or (@name='allowance') or (@name='expense')">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue/@name must have one of the following values: [allowance, expense]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval">
      <assert test="count(hrxml:EndDateTime) + count(hrxml:Duration) &gt; 0">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval must have EndDateTime or Duration</assert>
      <assert test="empty(@actionCode) or (@actionCode='Add') or (@actionCode='Change') or (@actionCode='Void') or (@actionCode='Unchanged')">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/@actionCode must have one of the following values: [Add, Change, Void, Unchanged]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements">
      <assert test="empty(hrxml:AdditionalRequirement) or (hrxml:AdditionalRequirement='true') or (hrxml:AdditionalRequirement='false')">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must have one of the following values: [true, false]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement">
      <assert test="empty(@requirementTitle) or (@requirementTitle='InclusiveRate')">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement/@requirementTitle must have one of the following values: [InclusiveRate]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount">
      <assert test="empty(@type) or (@type='hourly') or (@type='hourlyconsolidated') or (@type='hourlysplit') or (@type='4weekly') or (@type='monthly')">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount/@type must have one of the following values: [hourly, hourlyconsolidated, hourlysplit, 4weekly, monthly]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Price/oagis:PerQuantity">
      <assert test="number(text()) &gt; 0">oagis:Invoice/oagis:Line/oagis:Price/oagis:PerQuantity must be at least 1.</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Tax/oagis:PercentQuantity">
      <assert test="exists(index-of(/oagis:Invoice/oagis:Header/oagis:Tax/oagis:PercentQuantity, text()))">Invoice/Line/Tax/PercentQuantity must be available on Header level: <value-of select="text()"/></assert>
      <assert test="empty(@uom) or (@uom='BTW')">oagis:Invoice/oagis:Line/oagis:Tax/oagis:PercentQuantity/@uom must have one of the following values: [BTW]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard">
      <assert test="count(../../oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id) = 0">Invoice Line must not contain TimeCard on Line/Line level when it has a TimeCard itself</assert>
      <assert test="(count(hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId) + count(hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:PurchaseOrderNumber)) &gt;= 1">There must be at least one AssignmentId or PurchaseOrderNumber on header level.</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData">
      <assert test="count(hrxml:CustomerReportingRequirements) + count(hrxml:ReferenceInformation) &gt; 0">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData must contain CustomerReportingRequirements or ReferenceInformation</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation">
      <assert test="count(hrxml:StaffingSupplierId/@idOwner) = count(distinct-values(hrxml:StaffingSupplierId/@idOwner))">The same idOwner may not be given for StaffingSupplierId</assert>
      <assert test="if (count(hrxml:StaffingCustomerOrgUnitId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingCustomerOrgUnitId[@idOwner = 'KvK']) = 1) else ('true')">If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.</assert>
      <assert test="if (count(hrxml:StaffingCustomerId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingCustomerId[@idOwner = 'KvK']) = 1) else ('true')">If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.</assert>
      <assert test="if (count(hrxml:StaffingSupplierId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingSupplierId[@idOwner = 'KvK']) = 1) else ('true')">If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.</assert>
      <assert test="count(hrxml:StaffingCustomerId/@idOwner) = count(distinct-values(hrxml:StaffingCustomerId/@idOwner))">The same idOwner may not be given for StaffingCustomerId</assert>
      <assert test="count(hrxml:StaffingCustomerOrgUnitId/@idOwner) = count(distinct-values(hrxml:StaffingCustomerOrgUnitId/@idOwner))">The same idOwner may not be given for StaffingCustomerOrgUnitId</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCompany')">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId/@idOwner must have one of the following values: [StaffingCompany]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, OIN, KvK, BTW, Fi, Vest]</assert>
      <assert test="string-length() > 0">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId must be filled</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, OIN, KvK, BTW, Fi, Vest]</assert>
      <assert test="string-length() > 0">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId must be filled</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId">
      <assert test="string-length() > 0">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId must be filled</assert>
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, OIN, KvK, BTW, Fi, Vest]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='KvK') or (@idOwner='OIN') or (@idOwner='BTW') or (@idOwner='Fi')">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, KvK, OIN, BTW, Fi]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName/hrxml:Affix">
      <assert test="empty(@type) or (@type='aristocraticTitle') or (@type='formOfAddress') or (@type='generation') or (@type='qualification')">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName/hrxml:Affix/@type must have one of the following values: [aristocraticTitle, formOfAddress, generation, qualification]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName/hrxml:FamilyName">
      <assert test="empty(@primary) or (@primary='true') or (@primary='false')">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName/hrxml:FamilyName/@primary must have one of the following values: [true, false]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName/hrxml:Affix">
      <assert test="empty(@type) or (@type='aristocraticTitle') or (@type='formOfAddress') or (@type='generation') or (@type='qualification')">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName/hrxml:Affix/@type must have one of the following values: [aristocraticTitle, formOfAddress, generation, qualification]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName/hrxml:FamilyName">
      <assert test="empty(@primary) or (@primary='true') or (@primary='false')">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName/hrxml:FamilyName/@primary must have one of the following values: [true, false]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime">
      <assert test="count(hrxml:TimeInterval) + count(hrxml:Allowance) &gt; 0">hrxml:TimeCard/hrxml:ReportedTime must contain at least one TimeInterval or Allowance</assert>
      <assert test="(empty(@status) or (@status='rejected') or (@status='corrected')) or (empty(@status) or (@status=''))">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/@status must have one of the following values: [rejected, corrected] OR oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/@status must be Empty</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance">
      <assert test="empty(@actionCode) or (@actionCode='Add') or (@actionCode='Change') or (@actionCode='Void') or (@actionCode='Unchanged')">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/@actionCode must have one of the following values: [Add, Change, Void, Unchanged]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue">
      <assert test="empty(@name) or (@name='allowance') or (@name='expense')">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue/@name must have one of the following values: [allowance, expense]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval">
      <assert test="empty(@actionCode) or (@actionCode='Add') or (@actionCode='Change') or (@actionCode='Void') or (@actionCode='Unchanged')">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/@actionCode must have one of the following values: [Add, Change, Void, Unchanged]</assert>
      <assert test="count(hrxml:EndDateTime) + count(hrxml:Duration) &gt; 0">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval must have EndDateTime or Duration</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements">
      <assert test="empty(hrxml:AdditionalRequirement) or (hrxml:AdditionalRequirement='true') or (hrxml:AdditionalRequirement='false')">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must have one of the following values: [true, false]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement">
      <assert test="empty(@requirementTitle) or (@requirementTitle='InclusiveRate')">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement/@requirementTitle must have one of the following values: [InclusiveRate]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount">
      <assert test="empty(@type) or (@type='hourly') or (@type='hourlyconsolidated') or (@type='hourlysplit') or (@type='4weekly') or (@type='monthly')">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount/@type must have one of the following values: [hourly, hourlyconsolidated, hourlysplit, 4weekly, monthly]</assert>
    </rule>
  </pattern>
  <pattern id="type-restrictions-1">
    <rule context="oagis:Invoice/oagis:Header/oagis:TotalAmount[2]">
      <assert test="@currency != ../oagis:TotalAmount[1]/@currency">oagis:Invoice/oagis:Header/oagis:TotalAmount currencies must be different for each occurrence</assert>
    </rule>
  </pattern>
  <pattern id="type-restrictions-2">
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement[@requirementTitle = 'VersionId']">
      <assert test="text() = '2.0'">CustomerReportingRequirements/AdditionalRequirement must have value: 2.0 when requirementTitle is 'VersionId'.</assert>
    </rule>
  </pattern>
  <pattern id="type-restrictions-3">
    <rule context="oagis:Invoice/oagis:Header[oagis:ReasonCode='services']">
      <assert test="count(../oagis:Line/oagis:ReasonCode) = count(../oagis:Line)">Each Line must have a ReasonCode if the ReasonCode is 'services' in the Header.</assert>
      <assert test="count(../oagis:Line/oagis:Line/oagis:ReasonCode) = count(../oagis:Line/oagis:Line)">Each Line/Line must have a ReasonCode if the ReasonCode is 'services' in the Header.</assert>
    </rule>
  </pattern>
</schema>
