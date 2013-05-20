#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class ServiceSvc_rechercherCodesArretsDepuisLibelle;
@class ServiceSvc_rechercherCodesArretsDepuisLibelleResponse;
@class ServiceSvc_MessageRechercheCodeArret;
@class ServiceSvc_ArrayOfArret;
@class ServiceSvc_Arret;
@class ServiceSvc_CredentialHeader;
@class ServiceSvc_rechercheProchainesArriveesWeb;
@class ServiceSvc_rechercheProchainesArriveesWebResponse;
@class ServiceSvc_MessageArriveesAppliWeb;
@class ServiceSvc_ArrayOfArrivee;
@class ServiceSvc_Arrivee;
@class ServiceSvc_rechercheFichesHoraires;
@class ServiceSvc_rechercheFichesHorairesResponse;
@class ServiceSvc_MessageFichesHoraires;
@class ServiceSvc_ArrayOfFicheHoraire;
@class ServiceSvc_FicheHoraire;
@interface ServiceSvc_rechercherCodesArretsDepuisLibelle : NSObject {
	
/* elements */
	NSString * Saisie;
	NSNumber * NoPage;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ServiceSvc_rechercherCodesArretsDepuisLibelle *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * Saisie;
@property (retain) NSNumber * NoPage;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ServiceSvc_Arret : NSObject {
	
/* elements */
	NSString * Libelle;
	NSString * Code;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ServiceSvc_Arret *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * Libelle;
@property (retain) NSString * Code;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ServiceSvc_ArrayOfArret : NSObject {
	
/* elements */
	NSMutableArray *Arret;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ServiceSvc_ArrayOfArret *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addArret:(ServiceSvc_Arret *)toAdd;
@property (readonly) NSMutableArray * Arret;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ServiceSvc_MessageRechercheCodeArret : NSObject {
	
/* elements */
	USBoolean * Suite;
	ServiceSvc_ArrayOfArret * ListeArret;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ServiceSvc_MessageRechercheCodeArret *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) USBoolean * Suite;
@property (retain) ServiceSvc_ArrayOfArret * ListeArret;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ServiceSvc_rechercherCodesArretsDepuisLibelleResponse : NSObject {
	
/* elements */
	ServiceSvc_MessageRechercheCodeArret * rechercherCodesArretsDepuisLibelleResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ServiceSvc_rechercherCodesArretsDepuisLibelleResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) ServiceSvc_MessageRechercheCodeArret * rechercherCodesArretsDepuisLibelleResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ServiceSvc_CredentialHeader : NSObject {
	
/* elements */
	NSString * ID_;
	NSString * MDP;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ServiceSvc_CredentialHeader *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * ID_;
@property (retain) NSString * MDP;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ServiceSvc_rechercheProchainesArriveesWeb : NSObject {
	
/* elements */
	NSString * CodeArret;
	NSNumber * Mode;
	NSString * Heure;
	NSNumber * NbHoraires;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ServiceSvc_rechercheProchainesArriveesWeb *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * CodeArret;
@property (retain) NSNumber * Mode;
@property (retain) NSString * Heure;
@property (retain) NSNumber * NbHoraires;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ServiceSvc_Arrivee : NSObject {
	
/* elements */
	NSString * Mode;
	NSString * Destination;
	NSString * Horaire;
	USBoolean * EstApresMinuit;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ServiceSvc_Arrivee *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * Mode;
@property (retain) NSString * Destination;
@property (retain) NSString * Horaire;
@property (retain) USBoolean * EstApresMinuit;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ServiceSvc_ArrayOfArrivee : NSObject {
	
/* elements */
	NSMutableArray *Arrivee;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ServiceSvc_ArrayOfArrivee *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addArrivee:(ServiceSvc_Arrivee *)toAdd;
@property (readonly) NSMutableArray * Arrivee;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ServiceSvc_MessageArriveesAppliWeb : NSObject {
	
/* elements */
	ServiceSvc_ArrayOfArrivee * ListeArrivee;
	NSString * LibelleArret;
	NSString * HeureDemande;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ServiceSvc_MessageArriveesAppliWeb *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) ServiceSvc_ArrayOfArrivee * ListeArrivee;
@property (retain) NSString * LibelleArret;
@property (retain) NSString * HeureDemande;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ServiceSvc_rechercheProchainesArriveesWebResponse : NSObject {
	
/* elements */
	ServiceSvc_MessageArriveesAppliWeb * rechercheProchainesArriveesWebResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ServiceSvc_rechercheProchainesArriveesWebResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) ServiceSvc_MessageArriveesAppliWeb * rechercheProchainesArriveesWebResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ServiceSvc_rechercheFichesHoraires : NSObject {
	
/* elements */
	NSString * CodeArret;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ServiceSvc_rechercheFichesHoraires *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * CodeArret;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ServiceSvc_FicheHoraire : NSObject {
	
/* elements */
	NSString * LibelleDestination;
	NSString * Url;
	NSDate * DebutValidite;
	NSDate * FinValidite;
	NSNumber * TypePeriode;
	NSString * LibellePeriode;
	NSString * CodeArret;
	NSString * Ligne;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ServiceSvc_FicheHoraire *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * LibelleDestination;
@property (retain) NSString * Url;
@property (retain) NSDate * DebutValidite;
@property (retain) NSDate * FinValidite;
@property (retain) NSNumber * TypePeriode;
@property (retain) NSString * LibellePeriode;
@property (retain) NSString * CodeArret;
@property (retain) NSString * Ligne;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ServiceSvc_ArrayOfFicheHoraire : NSObject {
	
/* elements */
	NSMutableArray *FicheHoraire;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ServiceSvc_ArrayOfFicheHoraire *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addFicheHoraire:(ServiceSvc_FicheHoraire *)toAdd;
@property (readonly) NSMutableArray * FicheHoraire;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ServiceSvc_MessageFichesHoraires : NSObject {
	
/* elements */
	ServiceSvc_ArrayOfFicheHoraire * FichesHoraires;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ServiceSvc_MessageFichesHoraires *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) ServiceSvc_ArrayOfFicheHoraire * FichesHoraires;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ServiceSvc_rechercheFichesHorairesResponse : NSObject {
	
/* elements */
	ServiceSvc_MessageFichesHoraires * rechercheFichesHorairesResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ServiceSvc_rechercheFichesHorairesResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) ServiceSvc_MessageFichesHoraires * rechercheFichesHorairesResult;
/* attributes */
- (NSDictionary *)attributes;
@end
/* Cookies handling provided by http://en.wikibooks.org/wiki/Programming:WebObjects/Web_Services/Web_Service_Provider */
#import <libxml/parser.h>
#import "xsd.h"
#import "ServiceSvc.h"
@class ServiceSoapBinding;
@class ServiceSoap12Binding;
@interface ServiceSvc : NSObject {
	
}
+ (ServiceSoapBinding *)ServiceSoapBinding;
+ (ServiceSoap12Binding *)ServiceSoap12Binding;
@end
@class ServiceSoapBindingResponse;
@class ServiceSoapBindingOperation;
@protocol ServiceSoapBindingResponseDelegate <NSObject>
- (void) operation:(ServiceSoapBindingOperation *)operation completedWithResponse:(ServiceSoapBindingResponse *)response;
@end
@interface ServiceSoapBinding : NSObject <ServiceSoapBindingResponseDelegate> {
	NSURL *address;
	NSTimeInterval defaultTimeout;
	NSMutableArray *cookies;
	BOOL logXMLInOut;
	BOOL synchronousOperationComplete;
	NSString *authUsername;
	NSString *authPassword;
}
@property (copy) NSURL *address;
@property (assign) BOOL logXMLInOut;
@property (assign) NSTimeInterval defaultTimeout;
@property (nonatomic, retain) NSMutableArray *cookies;
@property (nonatomic, retain) NSString *authUsername;
@property (nonatomic, retain) NSString *authPassword;
- (id)initWithAddress:(NSString *)anAddress;
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(ServiceSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (ServiceSoapBindingResponse *)rechercherCodesArretsDepuisLibelleUsingParameters:(ServiceSvc_rechercherCodesArretsDepuisLibelle *)aParameters CredentialHeader:(ServiceSvc_CredentialHeader *)aCredentialHeader CredentialHeader:(ServiceSvc_CredentialHeader *)aCredentialHeader ;
- (void)rechercherCodesArretsDepuisLibelleAsyncUsingParameters:(ServiceSvc_rechercherCodesArretsDepuisLibelle *)aParameters CredentialHeader:(ServiceSvc_CredentialHeader *)aCredentialHeader CredentialHeader:(ServiceSvc_CredentialHeader *)aCredentialHeader  delegate:(id<ServiceSoapBindingResponseDelegate>)responseDelegate;
- (ServiceSoapBindingResponse *)rechercheProchainesArriveesWebUsingParameters:(ServiceSvc_rechercheProchainesArriveesWeb *)aParameters CredentialHeader:(ServiceSvc_CredentialHeader *)aCredentialHeader CredentialHeader:(ServiceSvc_CredentialHeader *)aCredentialHeader ;
- (void)rechercheProchainesArriveesWebAsyncUsingParameters:(ServiceSvc_rechercheProchainesArriveesWeb *)aParameters CredentialHeader:(ServiceSvc_CredentialHeader *)aCredentialHeader CredentialHeader:(ServiceSvc_CredentialHeader *)aCredentialHeader  delegate:(id<ServiceSoapBindingResponseDelegate>)responseDelegate;
- (ServiceSoapBindingResponse *)rechercheFichesHorairesUsingParameters:(ServiceSvc_rechercheFichesHoraires *)aParameters CredentialHeader:(ServiceSvc_CredentialHeader *)aCredentialHeader CredentialHeader:(ServiceSvc_CredentialHeader *)aCredentialHeader ;
- (void)rechercheFichesHorairesAsyncUsingParameters:(ServiceSvc_rechercheFichesHoraires *)aParameters CredentialHeader:(ServiceSvc_CredentialHeader *)aCredentialHeader CredentialHeader:(ServiceSvc_CredentialHeader *)aCredentialHeader  delegate:(id<ServiceSoapBindingResponseDelegate>)responseDelegate;
@end
@interface ServiceSoapBindingOperation : NSOperation {
	ServiceSoapBinding *binding;
	ServiceSoapBindingResponse *response;
	id<ServiceSoapBindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) ServiceSoapBinding *binding;
@property (readonly) ServiceSoapBindingResponse *response;
@property (nonatomic, assign) id<ServiceSoapBindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(ServiceSoapBinding *)aBinding delegate:(id<ServiceSoapBindingResponseDelegate>)aDelegate;
@end
@interface ServiceSoapBinding_rechercherCodesArretsDepuisLibelle : ServiceSoapBindingOperation {
	ServiceSvc_rechercherCodesArretsDepuisLibelle * parameters;
	ServiceSvc_CredentialHeader * CredentialHeader;
}
@property (retain) ServiceSvc_rechercherCodesArretsDepuisLibelle * parameters;
@property (retain) ServiceSvc_CredentialHeader * CredentialHeader;

- (id)initWithBinding:(ServiceSoapBinding *)aBinding delegate:(id<ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(ServiceSvc_rechercherCodesArretsDepuisLibelle *)aParameters
	CredentialHeader:(ServiceSvc_CredentialHeader *)aCredentialHeader
	CredentialHeader:(ServiceSvc_CredentialHeader *)aCredentialHeader
;
@end
@interface ServiceSoapBinding_rechercheProchainesArriveesWeb : ServiceSoapBindingOperation {
	ServiceSvc_rechercheProchainesArriveesWeb * parameters;
	ServiceSvc_CredentialHeader * CredentialHeader;

}
@property (retain) ServiceSvc_rechercheProchainesArriveesWeb * parameters;
@property (retain) ServiceSvc_CredentialHeader * CredentialHeader;

- (id)initWithBinding:(ServiceSoapBinding *)aBinding delegate:(id<ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(ServiceSvc_rechercheProchainesArriveesWeb *)aParameters
	CredentialHeader:(ServiceSvc_CredentialHeader *)aCredentialHeader
	CredentialHeader:(ServiceSvc_CredentialHeader *)aCredentialHeader
;
@end
@interface ServiceSoapBinding_rechercheFichesHoraires : ServiceSoapBindingOperation {
	ServiceSvc_rechercheFichesHoraires * parameters;
	ServiceSvc_CredentialHeader * CredentialHeader;

}
@property (retain) ServiceSvc_rechercheFichesHoraires * parameters;
@property (retain) ServiceSvc_CredentialHeader * CredentialHeader;

- (id)initWithBinding:(ServiceSoapBinding *)aBinding delegate:(id<ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(ServiceSvc_rechercheFichesHoraires *)aParameters
	CredentialHeader:(ServiceSvc_CredentialHeader *)aCredentialHeader
	CredentialHeader:(ServiceSvc_CredentialHeader *)aCredentialHeader
;
@end
@interface ServiceSoapBinding_envelope : NSObject {
}
+ (ServiceSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface ServiceSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
@class ServiceSoap12BindingResponse;
@class ServiceSoap12BindingOperation;
@protocol ServiceSoap12BindingResponseDelegate <NSObject>
- (void) operation:(ServiceSoap12BindingOperation *)operation completedWithResponse:(ServiceSoap12BindingResponse *)response;
@end
@interface ServiceSoap12Binding : NSObject <ServiceSoap12BindingResponseDelegate> {
	NSURL *address;
	NSTimeInterval defaultTimeout;
	NSMutableArray *cookies;
	BOOL logXMLInOut;
	BOOL synchronousOperationComplete;
	NSString *authUsername;
	NSString *authPassword;
}
@property (copy) NSURL *address;
@property (assign) BOOL logXMLInOut;
@property (assign) NSTimeInterval defaultTimeout;
@property (nonatomic, retain) NSMutableArray *cookies;
@property (nonatomic, retain) NSString *authUsername;
@property (nonatomic, retain) NSString *authPassword;
- (id)initWithAddress:(NSString *)anAddress;
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(ServiceSoap12BindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (ServiceSoap12BindingResponse *)rechercherCodesArretsDepuisLibelleUsingParameters:(ServiceSvc_rechercherCodesArretsDepuisLibelle *)aParameters CredentialHeader:(ServiceSvc_CredentialHeader *)aCredentialHeader CredentialHeader:(ServiceSvc_CredentialHeader *)aCredentialHeader ;
- (void)rechercherCodesArretsDepuisLibelleAsyncUsingParameters:(ServiceSvc_rechercherCodesArretsDepuisLibelle *)aParameters CredentialHeader:(ServiceSvc_CredentialHeader *)aCredentialHeader CredentialHeader:(ServiceSvc_CredentialHeader *)aCredentialHeader  delegate:(id<ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (ServiceSoap12BindingResponse *)rechercheProchainesArriveesWebUsingParameters:(ServiceSvc_rechercheProchainesArriveesWeb *)aParameters CredentialHeader:(ServiceSvc_CredentialHeader *)aCredentialHeader CredentialHeader:(ServiceSvc_CredentialHeader *)aCredentialHeader ;
- (void)rechercheProchainesArriveesWebAsyncUsingParameters:(ServiceSvc_rechercheProchainesArriveesWeb *)aParameters CredentialHeader:(ServiceSvc_CredentialHeader *)aCredentialHeader CredentialHeader:(ServiceSvc_CredentialHeader *)aCredentialHeader  delegate:(id<ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (ServiceSoap12BindingResponse *)rechercheFichesHorairesUsingParameters:(ServiceSvc_rechercheFichesHoraires *)aParameters CredentialHeader:(ServiceSvc_CredentialHeader *)aCredentialHeader CredentialHeader:(ServiceSvc_CredentialHeader *)aCredentialHeader ;
- (void)rechercheFichesHorairesAsyncUsingParameters:(ServiceSvc_rechercheFichesHoraires *)aParameters CredentialHeader:(ServiceSvc_CredentialHeader *)aCredentialHeader CredentialHeader:(ServiceSvc_CredentialHeader *)aCredentialHeader  delegate:(id<ServiceSoap12BindingResponseDelegate>)responseDelegate;
@end
@interface ServiceSoap12BindingOperation : NSOperation {
	ServiceSoap12Binding *binding;
	ServiceSoap12BindingResponse *response;
	id<ServiceSoap12BindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) ServiceSoap12Binding *binding;
@property (readonly) ServiceSoap12BindingResponse *response;
@property (nonatomic, assign) id<ServiceSoap12BindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(ServiceSoap12Binding *)aBinding delegate:(id<ServiceSoap12BindingResponseDelegate>)aDelegate;
@end
@interface ServiceSoap12Binding_rechercherCodesArretsDepuisLibelle : ServiceSoap12BindingOperation {
	ServiceSvc_rechercherCodesArretsDepuisLibelle * parameters;
	ServiceSvc_CredentialHeader * CredentialHeader;

}
@property (retain) ServiceSvc_rechercherCodesArretsDepuisLibelle * parameters;
@property (retain) ServiceSvc_CredentialHeader * CredentialHeader;

- (id)initWithBinding:(ServiceSoap12Binding *)aBinding delegate:(id<ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(ServiceSvc_rechercherCodesArretsDepuisLibelle *)aParameters
	CredentialHeader:(ServiceSvc_CredentialHeader *)aCredentialHeader
	CredentialHeader:(ServiceSvc_CredentialHeader *)aCredentialHeader
;
@end
@interface ServiceSoap12Binding_rechercheProchainesArriveesWeb : ServiceSoap12BindingOperation {
	ServiceSvc_rechercheProchainesArriveesWeb * parameters;

	ServiceSvc_CredentialHeader * CredentialHeader;
}
@property (retain) ServiceSvc_rechercheProchainesArriveesWeb * parameters;
@property (retain) ServiceSvc_CredentialHeader * CredentialHeader;

- (id)initWithBinding:(ServiceSoap12Binding *)aBinding delegate:(id<ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(ServiceSvc_rechercheProchainesArriveesWeb *)aParameters
	CredentialHeader:(ServiceSvc_CredentialHeader *)aCredentialHeader
	CredentialHeader:(ServiceSvc_CredentialHeader *)aCredentialHeader
;
@end
@interface ServiceSoap12Binding_rechercheFichesHoraires : ServiceSoap12BindingOperation {
	ServiceSvc_rechercheFichesHoraires * parameters;
	ServiceSvc_CredentialHeader * CredentialHeader;

}
@property (retain) ServiceSvc_rechercheFichesHoraires * parameters;
@property (retain) ServiceSvc_CredentialHeader * CredentialHeader;

- (id)initWithBinding:(ServiceSoap12Binding *)aBinding delegate:(id<ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(ServiceSvc_rechercheFichesHoraires *)aParameters
	CredentialHeader:(ServiceSvc_CredentialHeader *)aCredentialHeader
	CredentialHeader:(ServiceSvc_CredentialHeader *)aCredentialHeader
;
@end
@interface ServiceSoap12Binding_envelope : NSObject {
}
+ (ServiceSoap12Binding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface ServiceSoap12BindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
