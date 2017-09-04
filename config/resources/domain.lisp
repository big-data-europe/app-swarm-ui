(in-package :mu-cl-resources)

(define-resource repository ()
  :class (s-prefix "doap:GitRepository")
  :properties `((:location :string ,(s-prefix "doap:location"))
                (:title :string ,(s-prefix "dct:title"))
                (:icon :string ,(s-prefix "w3vocab:icon"))
                (:branch :string ,(s-prefix "swarmui:branch")))
  :has-many `((pipeline-instance :via ,(s-prefix "swarmui:pipelines")
                                 :as "pipeline-instances"))
  :resource-base (s-url "http://swarm-ui.big-data-europe.eu/resources/repositories/")
  :on-path "repositories")

(define-resource pipeline-instance ()
  :class (s-prefix "swarmui:Pipeline")
  :properties `((:title :string ,(s-prefix "dct:title"))
                (:icon :string ,(s-prefix "w3vocab:icon"))
                (:restart-requested :string ,(s-prefix "swarmui:restartRequested"))
                (:update-requested :string ,(s-prefix "swarmui:updateRequested")))
  :has-one `((repository :via ,(s-prefix "swarmui:pipelines")
                         :inverse t
                         :as "repository")
             (stack :via ,(s-prefix "swarmui:pipelines")
                                    :inverse t
                                    :as "stack")
             (status :via ,(s-prefix "swarmui:status")
                     :as "status")
             (status :via ,(s-prefix "swarmui:requestedStatus")
                     :as "requested-status"))
  :has-many `((service :via ,(s-prefix "swarmui:services")
                       :as "services"))
  :resource-base (s-url "http://swarm-ui.big-data-europe.eu/resources/pipeline-instances/")
  :on-path "pipeline-instances")

(define-resource service ()
  :class (s-prefix "swarmui:Service")
  :properties `((:name :string ,(s-prefix "dct:title"))
                (:scaling :number ,(s-prefix "swarmui:scaling"))
                (:requested-scaling :number ,(s-prefix "swarmui:requestedScaling"))
                (:restart-requested :string ,(s-prefix "swarmui:restartRequested")))
  :has-one `((pipeline-instance :via ,(s-prefix "swarmui:services")
                                :inverse t
                                :as "pipeline-instance")
             (status :via ,(s-prefix "swarmui:status")
                     :as "status")
             (status :via ,(s-prefix "swarmui:requestedStatus")
                     :as "requested-status"))
  :resource-base (s-url "http://swarm-ui.big-data-europe.eu/resources/services/")
  :on-path "services")

(define-resource status ()
  :class (s-prefix "swarmui:Status")
  :properties `((:title :string ,(s-prefix "dct:title")))
  :has-many `((pipeline-instance :via ,(s-prefix "swarmui:status")
                                 :inverse t
                                 :as "pipeline-instances"))
  :resource-base (s-url "http://swarm-ui.big-data-europe.eu/resources/statuses/")
  :on-path "statuses")
;
(define-resource docker-compose ()
  :class (s-prefix "stackbuilder:DockerCompose")
  :properties `((:text :string ,(s-prefix "stackbuilder:text"))
                (:title :string ,(s-prefix "dct:title")))
  :has-many `((stack :via ,(s-prefix "swarmui:dockerComposeFile")
                                 :inverse t
                                 :as "stacks"))
  :resource-base (s-url "http://stack-builder.big-data-europe.eu/resources/docker-composes/")
  :on-path "docker-composes")

(define-resource stack ()
  :class (s-prefix "doap:Stack")
  :properties `((:title :string ,(s-prefix "dct:title"))
                (:icon :string ,(s-prefix "w3vocab:icon")))
  :has-many `((pipeline-instance :via ,(s-prefix "swarmui:pipelines")
                                 :as "pipeline-instances"))
  :has-one `((docker-compose :via ,(s-prefix "swarmui:dockerComposeFile")
                                :as "docker-file"))
  :resource-base (s-url "http://swarm-ui.big-data-europe.eu/resources/stacks/")
  :on-path "stacks")
  
;;;;
;; NOTE
;; docker-compose stop; docker-compose rm; docker-compose up
;; after altering this file.

;; Describe your resources here

;; The general structure could be described like this:
;;
;; (define-resource <name-used-in-this-file> ()
;;   :class <class-of-resource-in-triplestore>
;;   :properties `((<json-property-name-one> <type-one> ,<triplestore-relation-one>)
;;                 (<json-property-name-two> <type-two> ,<triplestore-relation-two>>))
;;   :has-many `((<name-of-an-object> :via ,<triplestore-relation-to-objects>
;;                                    :as "<json-relation-property>")
;;               (<name-of-an-object> :via ,<triplestore-relation-from-objects>
;;                                    :inverse t ; follow relation in other direction
;;                                    :as "<json-relation-property>"))
;;   :has-one `((<name-of-an-object :via ,<triplestore-relation-to-object>
;;                                  :as "<json-relation-property>")
;;              (<name-of-an-object :via ,<triplestore-relation-from-object>
;;                                  :as "<json-relation-property>"))
;;   :resource-base (s-url "<string-to-which-uuid-will-be-appended-for-uri-of-new-items-in-triplestore>")
;;   :on-path "<url-path-on-which-this-resource-is-available>")


;; An example setup with a catalog, dataset, themes would be:
;;
;; (define-resource catalog ()
;;   :class (s-prefix "dcat:Catalog")
;;   :properties `((:title :string ,(s-prefix "dct:title")))
;;   :has-many `((dataset :via ,(s-prefix "dcat:dataset")
;;                        :as "datasets"))
;;   :resource-base (s-url "http://webcat.tmp.semte.ch/catalogs/")
;;   :on-path "catalogs")

;; (define-resource dataset ()
;;   :class (s-prefix "dcat:Dataset")
;;   :properties `((:title :string ,(s-prefix "dct:title"))
;;                 (:description :string ,(s-prefix "dct:description")))
;;   :has-one `((catalog :via ,(s-prefix "dcat:dataset")
;;                       :inverse t
;;                       :as "catalog"))
;;   :has-many `((theme :via ,(s-prefix "dcat:theme")
;;                      :as "themes"))
;;   :resource-base (s-url "http://webcat.tmp.tenforce.com/datasets/")
;;   :on-path "datasets")

;; (define-resource distribution ()
;;   :class (s-prefix "dcat:Distribution")
;;   :properties `((:title :string ,(s-prefix "dct:title"))
;;                 (:access-url :url ,(s-prefix "dcat:accessURL")))
;;   :resource-base (s-url "http://webcat.tmp.tenforce.com/distributions/")
;;   :on-path "distributions")

;; (define-resource theme ()
;;   :class (s-prefix "tfdcat:Theme")
;;   :properties `((:pref-label :string ,(s-prefix "skos:prefLabel")))
;;   :has-many `((dataset :via ,(s-prefix "dcat:theme")
;;                        :inverse t
;;                        :as "datasets"))
;;   :resource-base (s-url "http://webcat.tmp.tenforce.com/themes/")
;;   :on-path "themes")

;;
